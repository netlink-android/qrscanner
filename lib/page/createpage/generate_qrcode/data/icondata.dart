import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:qr_scanner/const.dart';
import 'package:qr_scanner/model/datetime.dart';
import 'package:qr_scanner/storage/qrstorage.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../ads/native.dart';
import '../../../../model/qrcustom_model.dart';

class IconQrPage extends StatefulWidget {
  String data = '', image = '', titleType = '', typeicon = '';
  Color shapeColor = black, eyeColor = black;
  int shapevalue = 1, eyevalue = 1;
  IconQrPage({
    Key? key,
    required this.titleType,
    required this.data,
    required this.typeicon,
    required this.image,
    required this.shapeColor,
    required this.shapevalue,
    required this.eyeColor,
    required this.eyevalue,
  }) : super(key: key);

  @override
  State<IconQrPage> createState() => _IconQrPageState();
}

class _IconQrPageState extends State<IconQrPage> {
  bool favorite = false;
  StorageProvider save = StorageProvider();
  FileImage? fileImage;
  Future<void> addHistoryCustom() async {
    //store the user entered data in user object
    //store the user entered data in user object
    final now = DateTime.now();
    String dayStr = '';
    if (now.weekday == DateTime.monday) {
      dayStr = 'Moday';
    } else if (now.weekday == DateTime.tuesday) {
      dayStr = 'Tuesday';
    } else if (now.weekday == DateTime.wednesday) {
      dayStr = 'Wednesday';
    } else if (now.weekday == DateTime.thursday) {
      dayStr = 'Thursday';
    } else if (now.weekday == DateTime.friday) {
      dayStr = 'Friday';
    } else if (now.weekday == DateTime.saturday) {
      dayStr = 'Saturday';
    } else if (now.weekday == DateTime.sunday) {
      dayStr = 'Sunday';
    }
    String our =
        now.hour < 10 ? '0' + now.hour.toString() : now.hour.toString();
    String minu =
        now.minute < 10 ? '0' + now.minute.toString() : now.minute.toString();

    String time = our + ':' + minu;
    DateTimeModel date =
        DateTimeModel(dayStr, now.year, now.month, now.day, time);

    QrCustomModel qrCustomModel = new QrCustomModel(
        data: widget.data,
        type: widget.data,
        image: widget.image,
        titleType: widget.titleType,
        typeicon: widget.typeicon,
        bodyColor: widget.shapeColor.toString().substring(6, 16),
        eyeColor: widget.eyeColor.toString().substring(6, 16),
        bodyvalue: widget.shapevalue,
        eyevalue: widget.eyevalue,
        date: date,
        favorite: favorite);

    // encode / convert object into json string
    String dataQr = jsonEncode(qrCustomModel);

    //save the data into sharedPreferences using key-value pairs
    save.addData(dataQr);
  }

  @override
  void initState() {
    setState(() {
      addHistoryCustom();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 35,
                    ),
                  ),
                  Text(
                    widget.titleType,
                    style: textType,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //   child: IconButton(
                  //       onPressed: () {
                  //         setState(() {
                  //           favorite = !favorite;
                  //           toastFavorite();
                  //         });
                  //       },
                  //       icon: favorite
                  //           ? Icon(
                  //               Icons.star,
                  //               size: 35,
                  //               color: red,
                  //             )
                  //           : Icon(
                  //               Icons.star_border_outlined,
                  //               size: 35,
                  //             )),
                  // )
                  Container()
                ],
              ),
            ),
            Container(
              height: 320,
              width: double.infinity,
              color: blue.withOpacity(0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: white,
                    child: QrImage(
                      data: widget.data,
                      version: QrVersions.auto,
                      size: 250,
                      embeddedImage: widget.image !=
                              'assets/iconcustom/iconnew/noicon.png'
                          ? (widget.typeicon != 'FileAssets'
                              ? AssetImage(widget.image)
                              : FileImage(File(widget.image)) as ImageProvider)
                          : null,
                      embeddedImageStyle: QrEmbeddedImageStyle(
                        size: Size(52, 52),
                      ),
                      eyeStyle: QrEyeStyle(
                          eyeShape: widget.eyevalue == 1
                              ? QrEyeShape.square
                              : QrEyeShape.circle,
                          color: widget.eyeColor),
                      dataModuleStyle: QrDataModuleStyle(
                          dataModuleShape: widget.shapevalue == 1
                              ? QrDataModuleShape.square
                              : QrDataModuleShape.circle,
                          color: widget.shapeColor),
                      errorStateBuilder: (cxt, err) {
                        return Container(
                          child: Center(
                            child: Text(
                              "Uh oh! Something went wrong...",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text.rich(TextSpan(children: <InlineSpan>[
                      TextSpan(
                        text: widget.typeicon != 'Icon'
                            ? widget.typeicon + ': '
                            : '',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: widget.data,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ])),
                  ),
                ],
              ),
            ),
            Container(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color?>(blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        // side: BorderSide(color: Colors.red)
                      ))),
                  onPressed: () {
                    _qrDownload(widget.data);
                  },
                  child: Container(
                      width: 120,
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Save',
                            style: textType,
                          ),
                        ],
                      )),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color?>(blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        // side: BorderSide(color: Colors.red)
                      ))),
                  onPressed: () {
                    _share(widget.data);
                  },
                  child: Container(
                      width: 120,
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Share',
                            style: textType,
                          ),
                        ],
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            NativeAdManager(
              idNative: '/22486823495/sudoku_native',
            ),
          ],
        ),
      ),
    );
  }

  void toastFavorite() {
    if (favorite) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Added to Favorites"),
        duration: Duration(milliseconds: 700),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Deleted to Favorites"),
        duration: Duration(milliseconds: 700),
      ));
    }
  }

  _qrCode(String _txt) async {
    final qrValidationResult = QrValidator.validate(
        data: _txt,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L);

    qrValidationResult.status = QrValidationStatus.valid;
    final qrcode = qrValidationResult.qrCode;
    final painter = QrPainter.withQr(
      qr: qrcode!,
      embeddedImage:
          // widget.image != 'assets/iconcustom/iconnew/noicon.png'
          //     ? (widget.typeicon != 'FileAssets'
          //         ? Image(image: AssetImage(widget.i),)
          // : Image())
          null,
      // embeddedImageStyle: QrEmbeddedImageStyle(
      //   size: Size.square(60),
      // ),
      emptyColor: white,
      eyeStyle: QrEyeStyle(
          eyeShape:
              widget.eyevalue == 1 ? QrEyeShape.square : QrEyeShape.circle,
          color: widget.eyeColor),
      dataModuleStyle: QrDataModuleStyle(
          dataModuleShape: widget.shapevalue == 1
              ? QrDataModuleShape.square
              : QrDataModuleShape.circle,
          color: widget.shapeColor),
    );

    Directory _tempDir = await getTemporaryDirectory();
    String _tempPath = _tempDir.path;
    final _time = DateTime.now().microsecondsSinceEpoch.toString();
    String _finalPath = '$_tempPath/$_time.png';
    final picData =
        await painter.toImageData(2048, format: ImageByteFormat.png);
    await writeToFile(picData!, _finalPath);
    return _finalPath;
  }

  Future<String?> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  _qrDownload(String _path) async {
    String _finalPath = await _qrCode(_path);
    final _success = await GallerySaver.saveImage(_finalPath);
    if (_success != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Save Successfully"),
        duration: Duration(milliseconds: 400),
      ));
    }
  }

  _share(String _path) async {
    String _finalPath = await _qrCode(_path);
    await Share.shareFiles([_finalPath],
        mimeTypes: ['images/png'],
        subject: 'My Qr code',
        text: 'Please Scan me');
  }
}
