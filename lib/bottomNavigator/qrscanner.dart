import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:image_picker/image_picker.dart';
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
            data = resultFromPath.text.toString();
            setState(() {
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
                      });
                      print(data);

                      //MATMSG:TO:dungmoi2000@gmail.com;SUB:dd;BODY:0;;
                      // final splitted = data.split(RegExp(r';'));
                      // print(splitted);

                      // if (data.indexOf('MATMSG') == 0) {
                      //   print('email');
                      //   print(splitted[0].substring(10));
                      //   print(splitted[1].substring(4));
                      //   print(splitted[2].substring(5));
                      // } else if (data.indexOf('WIFI') == 0) {
                      //   print('wifi');
                      //   print(splitted[0].substring(7));
                      //   print(splitted[1].substring(2));
                      //   print(splitted[2].substring(2));
                      // } else {
                      //   print('no');
                      // }
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
                                      final resu = await Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (ctx) => DataQrPage(
                                                  titleType: 'Data',
                                                  data: data,
                                                  type: data,
                                                  typeicon:
                                                      'assets/iconcustom/iconnew/noicon.png')));
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
}
