import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_scanner/const.dart';
import 'package:qr_scanner/model/qrcustom_model.dart';
import 'package:qr_scanner/storage/qrstorage.dart';

class QrCreatedHistory extends StatefulWidget {
  const QrCreatedHistory({super.key});

  @override
  State<QrCreatedHistory> createState() => _QrCreatedHistoryState();
}

class _QrCreatedHistoryState extends State<QrCreatedHistory> {
  StorageProvider strSave = StorageProvider();
  List<dynamic> data = [];
  bool valuedata = false;

  List<QrCustomModel> qrCustomModel = [];
  final dataQr = GetStorage();

  @override
  void initState() {
    getStorageCreated();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return valuedata
        ? SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              size: 25,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: blue,
                            boxShadow: [
                              BoxShadow(
                                color: black.withOpacity(0.2),
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                        Text('Qr Created History', style: textType),
                        Container(
                          child: IconButton(
                            onPressed: () {
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.filter_list_alt,
                              size: 25,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    // Container(child: Text('Last')),
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      qrCustomModel[index].date.toString(),
                                      style: textType.copyWith(
                                          fontSize: 16,
                                          color: blue.withOpacity(0.7)),
                                    ),
                                    Text(
                                      qrCustomModel[index].date.time,
                                      style: textType.copyWith(
                                          fontSize: 16,
                                          color: blue.withOpacity(0.7)),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      print(qrCustomModel[index]);
                                      // addFo(index, user[index]);
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: grey.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                  height: 30,
                                                  width: 30,
                                                  child: Image.asset(
                                                      qrCustomModel[index]
                                                          .image)),
                                              SizedBox(width: 8),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    qrCustomModel[index].data,
                                                    style: textType.copyWith(
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    qrCustomModel[index]
                                                        .typeicon,
                                                    style: textType.copyWith(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.arrow_right,
                                            size: 40,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold();
  }

  Future<void> getStorageCreated() async {
    final now = DateTime.now();

    if (dataQr.read('data') != null) {
      // valuedata = true;

      data = dataQr.read('data');
      if (data.length >= 1) {
        setState(() {
          valuedata = true;
        });
      }

      for (String dataus in data) {
        Map<String, dynamic> jsondatais = jsonDecode(dataus);

        QrCustomModel userr = QrCustomModel.fromJson(jsondatais);
        qrCustomModel.add(userr);
        // final setday =
        //     DateTime(userr.date.year, userr.date.month, userr.date.day);

        // if (int.parse(now.day.toString()) - int.parse(setday.day.toString()) ==
        //     0) {
        //   userToday.add(userr);
        // } else if (int.parse(now.day.toString()) -
        //         int.parse(setday.day.toString()) ==
        //     1) {
        //   userYes.add(userr);
        // } else {
        //   user.add(userr);
        // }
      }
    }
  }

  Future<void> removeData(int id) async {
    await strSave.remoceItem(id);
    setState(() {
      valuedata = false;
    });
  }
  // Future<void> addFo(int id, QrCustomModel userdata) async {
  //   //store the user entered data in user object
  //   //store the user entered data in user object
  //   QrCustomModel userFr = new QrCustomModel(
  //       userdata.name,
  //       userdata.email,
  //       userdata.phone,
  //       Color(int.parse(userdata.color)).toString().substring(6, 16),
  //       userdata.date,
  //       userdata.time,
  //       true);

  //   // encode / convert object into json string
  //   String user11 = jsonEncode(userFr);

  //   //save the data into sharedPreferences using key-value pairs
  //   strSave.addDFavo(id, user11);
  // }
}
