import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../ads/native.dart';
import '../../const.dart';
import '../../model/datetime.dart';
import '../../model/qrcustom_model.dart';
import '../../storage/qrstorage.dart';

class TextUrlScan extends StatefulWidget {
  List<String> data = [];
  TextUrlScan({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<TextUrlScan> createState() => _TextUrlScanState();
}

class _TextUrlScanState extends State<TextUrlScan> {
  StorageProvider save = StorageProvider();
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
        data: widget.data[0],
        type: widget.data[0],
        image: widget.data[1] == 'link'
            ? ('assets/iconcustom/link.png')
            : ('assets/iconcustom/iconnew/${widget.data[1]}.png'),
        titleType: widget.data[1] == 'link'
            ? 'Url'
            : widget.data[1].substring(0, 1).toUpperCase() +
                widget.data[1].substring(1),
        typeicon: widget.data[1] == 'link'
            ? 'Url'
            : widget.data[1].substring(0, 1).toUpperCase() +
                widget.data[1].substring(1),
        bodyColor: black.toString().substring(6, 16),
        eyeColor: black.toString().substring(6, 16),
        bodyvalue: 1,
        eyevalue: 1,
        date: date,
        favorite: false);

    // encode / convert object into json string
    String dataQr = jsonEncode(qrCustomModel);
    print(dataQr);
    //save the data into sharedPreferences using key-value pairs
    save.addDataScanner(dataQr);
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
                      setState(() {
                        // Navigator.of(context).push(
                        //   new MaterialPageRoute(builder: (ctx) => MainPage()),
                        // );
                        Navigator.of(context).pop(true);
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
                        height: 22,
                        width: 22,
                        child: Icon(
                          Icons.link,
                          size: 25,
                        ),
                      ),
                      Container(
                        width: 5,
                      ),
                      Text(
                        'Url',
                        style: textType,
                      ),
                    ],
                  ),
                  Container(),
                ],
              ),
            ),
            Container(
              height: 170,
              width: double.infinity,
              color: blue.withOpacity(0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.data[1] == 'link'
                                ? 'Link url:'
                                : 'Link ' + widget.data[1] + ':',
                            style: textType.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      margin: EdgeInsets.only(top: 60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            widget.data[0],
                            style: textType.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: 70,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color?>(
                                        blue.withOpacity(0.8)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  // side: BorderSide(color: Colors.red)
                                ))),
                            onPressed: () {
                              launch('${widget.data[0]}');
                            },
                            child: widget.data[1] == 'link'
                                ? Image.asset('assets/iconcustom/link.png')
                                : Image.asset(
                                    'assets/iconcustom/iconnew/${widget.data[1]}.png')),
                      ),
                      Text(
                        'Open ${widget.data[1]}',
                        style: textType.copyWith(fontSize: 18),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: 70,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color?>(
                                        blue.withOpacity(0.8)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  // side: BorderSide(color: Colors.red)
                                ))),
                            onPressed: () {
                              setState(() {
                                _share(widget.data[0]);
                              });
                            },
                            child: Icon(
                              Icons.share,
                              color: black,
                              size: 40,
                            )),
                      ),
                      Text(
                        'Share',
                        style: textType.copyWith(fontSize: 18),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            NativeAdManager(
              idNative: '/22486823495/sudoku_native',small: true
            ),
          ],
        ),
      ),
    );
  }

  _share(String _data) async {
    await Share.share(_data);
  }
}
