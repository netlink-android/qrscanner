import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../ads/native.dart';
import '../../const.dart';
import '../../model/datetime.dart';
import '../../model/qrcustom_model.dart';
import '../../storage/qrstorage.dart';

class WifiScan extends StatefulWidget {
  List<String> data = [];
  WifiScan({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<WifiScan> createState() => _WifiScanState();
}

class _WifiScanState extends State<WifiScan> {
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
        data:
            'WIFI:S:${widget.data[0]};T:${widget.data[1]};P:${widget.data[2]};H:true;;',
        type: widget.data[0],
        image: 'assets/iconcustom/wifi.png',
        titleType: 'Wifi',
        typeicon: 'Wifi',
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
                        child: Icon(Icons.wifi, size: 30),
                      ),
                      Container(
                        width: 5,
                      ),
                      Text(
                        'Wifi',
                        style: textType,
                      ),
                    ],
                  ),
                  Container(),
                ],
              ),
            ),
            Container(
              height: 250,
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
                            'Network name:',
                            style: textType.copyWith(fontSize: 18),
                          ),
                          Text(
                            'Network type:',
                            style: textType.copyWith(fontSize: 18),
                          ),
                          Text(
                            'Password:',
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            widget.data[0],
                            style: textType.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            widget.data[1],
                            style: textType.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            widget.data[2],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textType.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w400),
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
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                duration: Duration(seconds: 1),
                                content: Text("No action"),
                              ));
                            },
                            child: Image.asset('assets/iconcustom/wifi.png')),
                      ),
                      Text(
                        'Connection',
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
                              _share('Network name: ${widget.data[0]}' +
                                  '\nPassword: ${widget.data[2]}');
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
