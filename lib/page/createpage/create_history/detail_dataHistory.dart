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
import 'package:qr_scanner/page/createpage/create_history/qrcreated_history.dart';
import 'package:qr_scanner/storage/qrstorage.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../model/qrcustom_model.dart';

class DetailDataHistory extends StatefulWidget {
  int id = 0;
  String data = '', type = '', image = '', titleType = '', typeicon = '';
  String shapeColor = '', eyeColor = '';
  int shapevalue = 1, eyevalue = 1;
  DateTimeModel dateTimeModel = DateTimeModel('', 0, 0, 0, '');
  bool favorite = false;
  DetailDataHistory({
    Key? key,
    required this.id,
    required this.titleType,
    required this.data,
    required this.type,
    required this.typeicon,
    required this.image,
    required this.shapeColor,
    required this.shapevalue,
    required this.eyeColor,
    required this.eyevalue,
    required this.dateTimeModel,
    required this.favorite,
  }) : super(key: key);

  @override
  State<DetailDataHistory> createState() => _DetailDataHistoryState();
}

class _DetailDataHistoryState extends State<DetailDataHistory> {
  bool favoritee = false;
  StorageProvider strSave = StorageProvider();
  @override
  void initState() {
    setState(() {
      favoritee = widget.favorite;
    });
    super.initState();
  }

  Future<void> addFavor(int id, QrCustomModel userdata) async {
    //store the user entered data in user object
    //store the user entered data in user object
    QrCustomModel qrCustomModel = new QrCustomModel(
        data: userdata.data,
        type: userdata.type,
        image: userdata.image,
        titleType: userdata.titleType,
        typeicon: userdata.typeicon,
        bodyColor: userdata.bodyColor,
        eyeColor: userdata.eyeColor,
        bodyvalue: userdata.eyevalue,
        eyevalue: userdata.eyevalue,
        date: userdata.date,
        favorite: userdata.favorite);

    // encode / convert object into json string
    String user11 = jsonEncode(qrCustomModel);

    //save the data into sharedPreferences using key-value pairs
    strSave.addDFavorite(id, user11);
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
                      setState(() {
                        Navigator.of(context).pop(favoritee);
                        // Navigator.of(context).push(
                        //    MaterialPageRoute(
                        //       builder: (ctx) => QrCreatedHistory()),
                        // );
                        // addFo(index, user[index]);
                      });
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
                        onPressed: !favoritee
                            ? () {
                                setState(() {
                                  favoritee = !favoritee;

                                  toastFavorite();
                                });
                              }
                            : null,
                        icon: favoritee
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
                      embeddedImage: widget.titleType == 'Custom'
                          ? AssetImage(widget.image)
                          : null,
                      embeddedImageStyle: QrEmbeddedImageStyle(
                        size: Size(52, 52),
                      ),
                      eyeStyle: QrEyeStyle(
                          eyeShape: widget.eyevalue == 1
                              ? QrEyeShape.square
                              : QrEyeShape.circle,
                          color: Color(int.parse(widget.eyeColor))),
                      dataModuleStyle: QrDataModuleStyle(
                          dataModuleShape: widget.shapevalue == 1
                              ? QrDataModuleShape.square
                              : QrDataModuleShape.circle,
                          color: Color(int.parse(widget.shapeColor))),
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
                        text: widget.typeicon + ': ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: widget.type,
                        style: TextStyle(
                          fontSize: 14,
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
          ],
        ),
      ),
    );
  }

  void toastFavorite() {
    if (favoritee) {
      QrCustomModel qrCustomModel = new QrCustomModel(
          data: widget.data,
          type: widget.type,
          image: widget.image,
          titleType: widget.titleType,
          typeicon: widget.typeicon,
          bodyColor: widget.shapeColor,
          eyeColor: widget.eyeColor,
          bodyvalue: widget.eyevalue,
          eyevalue: widget.eyevalue,
          date: widget.dateTimeModel,
          favorite: true);
      addFavor(widget.id, qrCustomModel);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Added to Favorites"),
        duration: Duration(milliseconds: 700),
      ));
    } else {
      QrCustomModel qrCustomModel = new QrCustomModel(
          data: widget.data,
          type: widget.type,
          image: widget.image,
          titleType: widget.titleType,
          typeicon: widget.typeicon,
          bodyColor: widget.shapeColor,
          eyeColor: widget.eyeColor,
          bodyvalue: widget.eyevalue,
          eyevalue: widget.eyevalue,
          date: widget.dateTimeModel,
          favorite: false);
      addFavor(widget.id, qrCustomModel);
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
      embeddedImage: null,
      // embeddedImageStyle: QrEmbeddedImageStyle(
      //   size: Size.square(60),
      // ),
      emptyColor: white,
      eyeStyle: QrEyeStyle(
          eyeShape:
              widget.eyevalue == 1 ? QrEyeShape.square : QrEyeShape.circle,
          color: Color(int.parse(widget.eyeColor))),
      dataModuleStyle: QrDataModuleStyle(
          dataModuleShape: widget.shapevalue == 1
              ? QrDataModuleShape.square
              : QrDataModuleShape.circle,
          color: Color(int.parse(widget.shapeColor))),
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
