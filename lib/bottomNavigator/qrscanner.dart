import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_scanner/page/homepage/call_scan.dart';
import 'package:qr_scanner/page/homepage/data_scan.dart';
import 'package:qr_scanner/page/homepage/email_scan.dart';
import 'package:qr_scanner/page/homepage/location_scan.dart';
import 'package:qr_scanner/page/homepage/sms_scan.dart';
import 'package:qr_scanner/page/homepage/textUrl_scan.dart';
import 'package:qr_scanner/page/homepage/whatsapp_scan.dart';
import 'package:qr_scanner/page/homepage/wifi_scan.dart';
import 'package:url_launcher/url_launcher.dart';

import '../const.dart';
import '../page/homepage/dataQr_page.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  double _currentSliderValue = 70;
  bool isFile = false;
  File? fileImage;
  Uint8List? memoryImage;
  String data = '';
  bool codeState = false;
  String typeScanner = '';
  List<String> dataScanner = [];
  
  @override
  void initState() {
    // TODO: implement initState
    zx.startCameraProcessing();
    codeState = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isCameraSupported = defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "btnImage",
        onPressed: () async {
          final picker = ImagePicker();
          final pickedFile = await picker.getImage(source: ImageSource.gallery);

          if (pickedFile == null) return;

          final file = File(pickedFile.path);

          setState(() {
            fileImage = file;
            print(fileImage);
          });

          Code? resultFromPath =
              await zx.readBarcodeImagePathString(fileImage!.path);
          print(resultFromPath);
          if (resultFromPath!.rawBytes != null) {
            setState(() {
              data = resultFromPath.text.toString();
              codeState = true;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Image not found qr"),
              duration: Duration(milliseconds: 400),
            ));
            setState(() {
              codeState = false;
            });

            // if (isFile) {
            //   final file = File(pickedFile.path);

            //   setState(() {
            //     fileImage = file;
            //     print(fileImage);
            //   });
            // } else {
            //   final bytes = await pickedFile.readAsBytes();

            //   setState(() {
            //     memoryImage = bytes;
            //     print(memoryImage);
            //   });
            //   // Uint8List imbytes = Uint8List.fromList(memoryImage!);
            //   // Code? resultFromBytes = await zx.readBarcode(imbytes,
            //   //     height: 500, width: 500);
            //   // print(resultFromBytes);
            //   // print(resultFromBytes.text);
            //   // print(resultFromBytes.rawBytes);
            // }
          }
          // Add your onPressed code here!
        },
        backgroundColor: black.withOpacity(0.5),
        child: Container(
            padding: EdgeInsets.all(16),
            child: Image.asset(
              'assets/iconcustom/upload.png',
              color: white.withOpacity(0.8),
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Expanded(
                  child: ReaderWidget(
                    cropPercent: _currentSliderValue / 100,
                    onScan: (result) async {
                      print(result.text.toString());
                      data = await result.text.toString();

                      setState(() {
                        codeState = true;
                        dataScanner.clear();
                      });
                      print(data);
                      if (data.indexOf('MATMSG') == 0) {
                        print('email');
                        typeScanner = 'email';
                        print(extractEmailsFromString(data));
                        print(data.substring(
                            data.indexOf('SUB:') + 4, data.indexOf(';BODY:')));
                        print(data.substring(
                            data.indexOf(';BODY:') + 6, data.length - 2));
                        dataScanner.add(extractEmailsFromString(data));
                        dataScanner.add(data.substring(
                            data.indexOf('SUB:') + 4, data.indexOf(';BODY:')));
                        dataScanner.add(data.substring(
                            data.indexOf(';BODY:') + 6, data.length - 2));
                      } else if (data.indexOf('mailto') == 0) {
                        print('email');
                        typeScanner = 'email';
                        dataScanner.add(extractEmailsFromString(data));
                        dataScanner.add(data.substring(
                            data.indexOf('subject=') + 8,
                            data.indexOf('&body=')));
                        dataScanner
                            .add(data.substring(data.indexOf('&body=') + 6));
                      } else if (data.indexOf('tel') == 0) {
                        print('call');
                        typeScanner = 'call';
                        dataScanner
                            .add(data.substring(data.indexOf('tel:') + 4));
                      } else if (data.indexOf('WIFI') == 0) {
                        print('wifi');
                        typeScanner = 'wifi';
                        if (data.indexOf('WIFI:S:') == 0) {
                          dataScanner.add(data.substring(
                              data.indexOf('WIFI:S:') + 7,
                              data.indexOf(';T:')));
                          dataScanner.add(data.substring(
                              data.indexOf(';T:') + 3, data.indexOf(';P:')));
                          if (data.indexOf(';H:') > 0) {
                            dataScanner.add(data.substring(
                                data.indexOf(';P:') + 3, data.indexOf(';H:')));
                          } else {
                            dataScanner.add(data.substring(
                                data.indexOf(';P:') + 3, data.indexOf(';;')));
                          }
                        } else {
                          dataScanner.add(data.substring(
                              data.indexOf('WIFI:T:') + 7,
                              data.indexOf(';S:')));
                          dataScanner.add(data.substring(
                              data.indexOf(';S:') + 3, data.indexOf(';P:')));
                          dataScanner.add(data.substring(
                              data.indexOf(';P:') + 3, data.indexOf(';H')));
                        }
                      } else if (data.indexOf('geo') == 0 ||
                          data.indexOf('https://maps.google.com') == 0) {
                        print('location');
                        print(data);
                        typeScanner = 'location';
                        final splitLocation =
                            data.substring(data.indexOf('?q=') + 3).split(',');
                        // dataScanner
                        //     .add(data.substring(data.indexOf('?q=') + 3));
                        dataScanner.add(splitLocation[0]);
                        dataScanner.add(splitLocation[1]);
                      } else if (data.indexOf('SMSTO') == 0) {
                        print('SMSTO');
                        typeScanner = 'SMSTO';
                        final splitted = data.split(':');
                        dataScanner.add(splitted[1]);
                        dataScanner.add(data.substring(7 + splitted[1].length));
                      } else if (data.indexOf('https://wa.me') == 0) {
                        print('whatsapp');
                        typeScanner = 'whatsapp';
                        dataScanner.add(data.substring(
                            data.indexOf('://wa.me/') + 9,
                            data.indexOf('/?text=')));
                        dataScanner
                            .add(data.substring(data.indexOf('/?text=') + 7));
                      } else if (data.indexOf('skype') == 0) {
                        print('skype');
                        typeScanner = 'skype';
                        dataScanner.add(data);
                      } else if (data.indexOf('https://zoom.us') == 0) {
                        print('zoom');
                        typeScanner = 'zoom';
                        dataScanner.add(data);
                        // dataScanner.add(data.substring(
                        //     data.indexOf('.us/j/') + 6, data.indexOf('?pwd=')));
                        // dataScanner.add(data.substring(
                        //   data.lastIndexOf('?pwd=') + 5,
                        // ));
                      } else if (data.indexOf('https://www.facebook.com') ==
                          0) {
                        typeScanner = 'facebook';
                        dataScanner.add(data);
                        dataScanner.add(typeScanner);
                      } else if (data.indexOf('https://www.twitter.com') == 0) {
                        typeScanner = 'twiter';
                        dataScanner.add(data);
                        dataScanner.add(typeScanner);
                      } else if (data.indexOf('https://www.youtube.com') == 0) {
                        typeScanner = 'youtube';
                        dataScanner.add(data);
                        dataScanner.add(typeScanner);
                      } else if (data.indexOf('https://') == 0) {
                        print('link');
                        typeScanner = 'link';
                        dataScanner.add(data);
                        dataScanner.add(typeScanner);
                      } else {
                        typeScanner = 'data';
                        dataScanner.add(data);
                      }
                    },
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 2.8 / 4,
                  child: Container(
                    child: Slider(
                      value: _currentSliderValue,
                      activeColor: Colors.white,
                      inactiveColor: Colors.grey,
                      max: 100,
                      min: 60,
                      // divisions: 5,
                      // label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: AnimatedContainer(
                      width: codeState ? 300 : 0,
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        color: white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            codeState = false;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.close_sharp,
                                          size: 40,
                                          color: red,
                                        )),
                                  ],
                                ),
                                Center(
                                  child: Text(
                                    codeState ? 'Data: $data' : '',
                                    style: textType.copyWith(
                                        fontSize: 20, color: black),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                ElevatedButton(
                                    onPressed: () async {
                                      Widget _pageScane =
                                          DataScan(data: dataScanner);
                                      if (typeScanner == 'email') {
                                        _pageScane =
                                            EmailScan(data: dataScanner);
                                      } else if (typeScanner == 'call') {
                                        _pageScane =
                                            CallScan(data: dataScanner);
                                      } else if (typeScanner == 'wifi') {
                                        _pageScane =
                                            WifiScan(data: dataScanner);
                                      } else if (typeScanner == 'location') {
                                        _pageScane =
                                            LocationScan(data: dataScanner);
                                      } else if (typeScanner == 'SMSTO') {
                                        _pageScane = SmsScan(data: dataScanner);
                                      } else if (typeScanner == 'whatsapp') {
                                        _pageScane =
                                            WhatsAppScan(data: dataScanner);
                                      } else if (typeScanner == 'whatsapp') {
                                        _pageScane =
                                            WhatsAppScan(data: dataScanner);
                                      } else if (typeScanner == 'data') {
                                        _pageScane =
                                            DataScan(data: dataScanner);
                                      } else {
                                        _pageScane =
                                            TextUrlScan(data: dataScanner);
                                      }
                                      final resu = await Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (ctx) => _pageScane));
                                      if (resu != null) {
                                        setState(() {
                                          codeState = false;
                                        });
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text('View'),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: blue,
                                          ),
                                        )
                                      ],
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String extractEmailsFromString(String string) {
    final emailPattern = RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b',
        caseSensitive: false, multiLine: true);
    final matches = emailPattern.allMatches(string);
    List<String> emails = [];
    if (matches != null) {
      for (final Match match in matches) {
        emails.add(string.substring(match.start, match.end));
      }
    }

    return emails[0];
  }
}
