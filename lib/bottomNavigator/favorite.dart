import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_scanner/const.dart';
import 'package:qr_scanner/model/qrcustom_model.dart';
import 'package:qr_scanner/storage/qrstorage.dart';

import '../ads/banner.dart';
import '../page/createpage/create_history/detail_dataHistory.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  StorageProvider strSave = StorageProvider();
  List<dynamic> data = [];

  bool valuedata = false;

  bool _checkDelete = true;

  List<QrCustomModel> qrCustomModel = [];
  final dataQr = GetStorage();

  bool _isFilter = false;
  List<String> _listFilter = [
    'Email',
    'Text',
    'Call',
    'Wifi',
    'Location',
    'SMS',
    'Url',
     'FileAssets',
    'WhatsApp',
    'Skype',
    'Zoom',
    'Facebook',
    'Twitter',
    'Youtube',
  ];
  List<bool> _islistFilter = List<bool>.filled(14, false);
  Future<void> getFilter() async {
    // _qrCustomModelFil.clear();
    qrCustomModel.clear();
    for (String dataus in data) {
      Map<String, dynamic> jsondatais = jsonDecode(dataus);

      QrCustomModel _dtFilter = QrCustomModel.fromJson(jsondatais);
      if (_dtFilter.favorite == true) {
        for (int i = 0; i < _listFilter.length; i++) {
          if (_islistFilter[i]) {
            if (_dtFilter.typeicon == _listFilter[i]) {
              qrCustomModel.add(_dtFilter);
            }
          }
        }
      }
    }
  }

  @override
  void initState() {
    setState(() {
      getStorageCreated();
    });

    super.initState();
  }

  Future<void> deletedFovorite(int id, QrCustomModel userdata) async {
    String user11 = jsonEncode(userdata);
    //save the data into sharedPreferences using key-value pairs
    // strSave.addDFavorite(id, user11);
    strSave.remoceFavorite(id);
    setState(() {
      getStorageCreated();
    });
  }

  @override
  Widget build(BuildContext context) {
    return valuedata
        ? SafeArea(
            child: Scaffold(
              bottomNavigationBar: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  // color: white,
                  // boxShadow: [
                  //   _isFilter
                  //       ? BoxShadow(
                  //           color: black.withOpacity(0.01),
                  //           offset: Offset(1,3),
                  //           // spreadRadius: 5,
                  //           blurRadius: 10
                  //           )
                  //       : BoxShadow()
                  // ],
                ),
                height:
                    _isFilter ? MediaQuery.of(context).size.height * 0.55 : 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: ListView.builder(
                      itemCount: _listFilter.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 5),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              color: blue.withOpacity(0.2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        height: 30,
                                        width: 30,
                                        child: index < 7
                                            ? Image.asset(
                                                'assets/iconcustom/${_listFilter[index].toLowerCase()}.png')
                                            : Image.asset(
                                                'assets/iconcustom/iconnew/${_listFilter[index].toLowerCase()}.png')),
                                    Container(
                                      width: 10,
                                    ),
                                    Text(
                                      _listFilter[index],
                                      style: textType.copyWith(fontSize: 18),
                                    ),
                                  ],
                                ),
                                Checkbox(
                                    value: _islistFilter[index],
                                    onChanged: (value) {
                                      _islistFilter[index] =
                                          !_islistFilter[index];

                                      setState(() {
                                        _checkDelete = false;
                                        value = _islistFilter[index];
                                        getFilter();
                                        if (_islistFilter[0] == false &&
                                            _islistFilter[1] == false &&
                                            _islistFilter[2] == false &&
                                            _islistFilter[3] == false &&
                                            _islistFilter[0] == false &&
                                            _islistFilter[4] == false &&
                                            _islistFilter[5] == false &&
                                            _islistFilter[6] == false &&
                                            _islistFilter[7] == false &&
                                            _islistFilter[8] == false &&
                                            _islistFilter[9] == false &&
                                            _islistFilter[10] == false &&
                                            _islistFilter[11] == false &&
                                            _islistFilter[12] == false &&
                                            _islistFilter[13] == false) {
                                              _checkDelete = true;
                                          getStorageCreated();
                                        }
                                      });
                                      // print(_islistFilter);
                                    })
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
              body: Column(
                children: [
                  CustomBannerAd(idBanner: '/22486823495/sudoku_banner'),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 16, right: 16, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Favorite', style: textType),
                              Container(
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isFilter = !_isFilter;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.filter_list_alt,
                                    size: 25,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: blue,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: black.withOpacity(0.3),
                                      offset: Offset(1, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 7),
                          // Container(child: Text('Last')),
                          Expanded(
                            child: ListView.builder(
                              itemCount: qrCustomModel.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              qrCustomModel[index]
                                                  .date
                                                  .toString(),
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
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: grey.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Slidable(
                                          enabled: _checkDelete,
                                          endActionPane: ActionPane(
                                              extentRatio: 0.15,
                                              motion: const BehindMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (context) {
                                                    QrCustomModel qrCustomModelsend = new QrCustomModel(
                                                        data: qrCustomModel[index]
                                                            .data,
                                                        type: qrCustomModel[index]
                                                            .type,
                                                        image:
                                                            qrCustomModel[index]
                                                                .image,
                                                        titleType:
                                                            qrCustomModel[index]
                                                                .titleType,
                                                        typeicon:
                                                            qrCustomModel[index]
                                                                .typeicon,
                                                        bodyColor:
                                                            qrCustomModel[index]
                                                                .bodyColor,
                                                        eyeColor:
                                                            qrCustomModel[index]
                                                                .eyeColor,
                                                        bodyvalue:
                                                            qrCustomModel[index]
                                                                .bodyvalue,
                                                        eyevalue:
                                                            qrCustomModel[index]
                                                                .eyevalue,
                                                        date:
                                                            qrCustomModel[index]
                                                                .date,
                                                        favorite: false);

                                                    setState(() {
                                                      deletedFovorite(index,
                                                          qrCustomModelsend);
                                                    });
                                                  },
                                                  icon: Icons
                                                      .delete_outline_rounded,
                                                  foregroundColor: red,
                                                  autoClose: true,
                                                  backgroundColor:
                                                      grey.withOpacity(0.1),
                                                  // borderRadius:
                                                  //     const BorderRadius.horizontal(
                                                  //         right: Radius.circular(20)),
                                                )
                                              ]),
                                          child: GestureDetector(
                                            onTap: () async {
                                              final result =
                                                  await Navigator.of(context)
                                                      .push(
                                                MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      DetailDataHistory(
                                                    id: index,
                                                    titleType:
                                                        qrCustomModel[index]
                                                            .titleType,
                                                    data: qrCustomModel[index]
                                                        .data,
                                                    type: qrCustomModel[index]
                                                        .type,
                                                    typeicon:
                                                        qrCustomModel[index]
                                                            .typeicon,
                                                    image: qrCustomModel[index]
                                                        .image,
                                                    shapeColor:
                                                        qrCustomModel[index]
                                                            .bodyColor,
                                                    shapevalue:
                                                        qrCustomModel[index]
                                                            .bodyvalue,
                                                    eyeColor:
                                                        qrCustomModel[index]
                                                            .eyeColor,
                                                    eyevalue:
                                                        qrCustomModel[index]
                                                            .eyevalue,
                                                    dateTimeModel:
                                                        qrCustomModel[index]
                                                            .date,
                                                    favorite:
                                                        qrCustomModel[index]
                                                            .favorite,
                                                  ),
                                                ),
                                              );

                                              if (result != null) {
                                                setState(() {
                                                  getStorageCreated();
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: grey.withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 30,
                                                          width: 30,
                                                          child: (qrCustomModel[
                                                                          index]
                                                                      .typeicon !=
                                                                  'FileAssets'
                                                              ? Image.asset(
                                                                  qrCustomModel[
                                                                          index]
                                                                      .image)
                                                              : Image.file(File(
                                                                  qrCustomModel[
                                                                          index]
                                                                      .image))),
                                                        ),
                                                        SizedBox(width: 8),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.75,
                                                              child: Text(
                                                                qrCustomModel[
                                                                        index]
                                                                    .type,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: textType
                                                                    .copyWith(
                                                                        fontSize:
                                                                            16),
                                                              ),
                                                            ),
                                                            Text(
                                                              qrCustomModel[
                                                                      index]
                                                                  .typeicon,
                                                              style: textType.copyWith(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    // Icon(
                                                    //   Icons.arrow_right,
                                                    //   size: 40,
                                                    // ),
                                                  ],
                                                ),
                                              ),
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
                ],
              ),
            ),
          )
        : SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  CustomBannerAd(idBanner: '/22486823495/sudoku_banner'),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Favorite', style: textType),
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
                                  boxShadow: [
                                    BoxShadow(
                                      color: black.withOpacity(0.3),
                                      offset: Offset(1, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Future<void> getStorageCreated() async {
    qrCustomModel.clear();
    final now = DateTime.now();

    if (dataQr.read('dataFavorite') != null) {
      // valuedata = true;

      data = dataQr.read('dataFavorite');
      if (data.length >= 1) {
        setState(() {
          valuedata = true;
        });
      }

      for (String dataus in data) {
        Map<String, dynamic> jsondatais = jsonDecode(dataus);

        QrCustomModel userr = QrCustomModel.fromJson(jsondatais);

        qrCustomModel.add(userr);

        // qrCustomModel.add(userr);
      }
    }
  }
}
