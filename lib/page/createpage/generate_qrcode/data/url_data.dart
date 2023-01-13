import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:qr_scanner/const.dart';
import 'package:share_plus/share_plus.dart';

class UrlQrPage extends StatefulWidget {
  String data = '', type ='', titleType = '' ;
  UrlQrPage({Key? key,required this.titleType, required this.data, required this.type}) : super(key: key);

  @override
  State<UrlQrPage> createState() => _UrlQrPageState();
}

class _UrlQrPageState extends State<UrlQrPage> {
  bool favorite = false;
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
                  Row(
                    children: [
                      Container(
                        width: 15,
                      ),
                      Text(
                        widget.titleType,
                        style: textType,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            favorite = !favorite;
                            toastFavorite();
                          });
                        },
                        icon: favorite
                            ? Icon(
                                Icons.star,
                                size: 35,
                                color: red,
                              )
                            : Icon(
                                Icons.star_border_outlined,
                                size: 35,
                              )),
                  )
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
                      // foregroundColor: Colors.red,
                      // embeddedImage: NetworkImage(
                      //     'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
                      // embeddedImageStyle: QrEmbeddedImageStyle(
                      //   size: Size(80, 80),
                      // ),
                      // eyeStyle:
                      //     const QrEyeStyle(eyeShape: QrEyeShape.circle, color: Colors.red),
                      // dataModuleStyle: const QrDataModuleStyle(
                      //     dataModuleShape: QrDataModuleShape.circle, color: Colors.green),
                      // gapless: false,
                      // errorStateBuilder: (cxt, err) {
                      //   return Container(
                      //     child: Center(
                      //       child: Text(
                      //         "Uh oh! Something went wrong...",
                      //         textAlign: TextAlign.center,
                      //       ),
                      //     ),
                      //   );
                      // },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      widget.type,
                      style: textType.copyWith(fontSize: 18),
                    ),
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
          ],
        ),
      ),
    );
  }

  void toastFavorite() {
    if (favorite) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Added to Favorites"),
        duration: Duration(milliseconds: 400),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Deleted to Favorites"),
        duration: Duration(milliseconds: 400),
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
        color: Color(0xfffffffff),
        embeddedImageStyle: null,
        emptyColor: black,
        gapless: true);

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