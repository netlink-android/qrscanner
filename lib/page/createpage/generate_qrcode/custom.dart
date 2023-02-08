import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/model/qrcustom_model.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/data/icondata.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/data/url_data.dart';

import '../../../const.dart';

class CustomPageQr extends StatefulWidget {
  const CustomPageQr({super.key});

  @override
  State<CustomPageQr> createState() => _CustomPageQrState();
}

class _CustomPageQrState extends State<CustomPageQr> {
  TextEditingController texturl = TextEditingController();

  bool _iconOption = false;
  bool _shapeOption = false;
  bool _eyeOption = false;
  String _asseticon = 'assets/iconcustom/iconnew/noicon.png';
  String _texticon = 'Icon';
  Color _shapeColor = black;
  Color _eyeColor = black;
  int _shapevalue = 1, _eyevalue = 1;

  @override
  void initState() {
    // TODO: implement initState

    texturl = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    setState(() {
      _iconOption = false;
      _shapeOption = false;
      _eyeOption = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Custom'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: texturl,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.social_distance_outlined,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              FocusScope.of(context).unfocus();
                              deleteText();
                            });
                          },
                          icon: Icon(Icons.close_rounded)),
                      hintText: 'Please enter text',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: grey, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: black),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(color: grey),
                      color: grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 30,
                          width: 40,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Image.asset(_asseticon),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            _texticon,
                            style: textType.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _shapeOption = false;
                                _eyeOption = false;
                                _iconOption = !_iconOption;
                              });
                            },
                            icon: Icon(Icons.menu))
                      ],
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: _iconOption ? 250 : 0,
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: blue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color?>(
                                              white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        // side: BorderSide(color: Colors.red)
                                      ))),
                                  onPressed: () {
                                    setState(() {
                                      _texticon = 'Facebook';
                                      _asseticon =
                                          'assets/iconcustom/iconnew/facebook.png';
                                      _iconOption = false;
                                    });
                                  },
                                  child: Image.asset(
                                      'assets/iconcustom/iconnew/facebook.png'),
                                ),
                              ),
                              Container(
                                height: 60,
                                width: 60,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color?>(
                                              white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        // side: BorderSide(color: Colors.red)
                                      ))),
                                  onPressed: () {
                                    setState(() {
                                      _texticon = 'Instagram';
                                      _asseticon =
                                          'assets/iconcustom/iconnew/instagram.png';
                                      _iconOption = false;
                                    });
                                  },
                                  child: Image.asset(
                                      'assets/iconcustom/iconnew/instagram.png'),
                                ),
                              ),
                              Container(
                                height: 60,
                                width: 60,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color?>(
                                              white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        // side: BorderSide(color: Colors.red)
                                      ))),
                                  onPressed: () {
                                    setState(() {
                                      _texticon = 'Youtube';
                                      _asseticon =
                                          'assets/iconcustom/iconnew/youtube.png';
                                      _iconOption = false;
                                    });
                                  },
                                  child: Image.asset(
                                      'assets/iconcustom/iconnew/youtube.png'),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color?>(
                                              white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        // side: BorderSide(color: Colors.red)
                                      ))),
                                  onPressed: () {
                                    setState(() {
                                      _texticon = 'Twiter';
                                      _asseticon =
                                          'assets/iconcustom/iconnew/twitter.png';
                                      _iconOption = false;
                                    });
                                  },
                                  child: Image.asset(
                                      'assets/iconcustom/iconnew/twitter.png'),
                                ),
                              ),
                              Container(
                                height: 60,
                                width: 60,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color?>(
                                              white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        // side: BorderSide(color: Colors.red)
                                      ))),
                                  onPressed: () {
                                    setState(() {
                                      _texticon = 'Linkin';
                                      _asseticon =
                                          'assets/iconcustom/iconnew/linkin.png';
                                      _iconOption = false;
                                    });
                                  },
                                  child: Image.asset(
                                      'assets/iconcustom/iconnew/linkin.png'),
                                ),
                              ),
                              Container(
                                height: 60,
                                width: 60,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color?>(
                                              white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        // side: BorderSide(color: Colors.red)
                                      ))),
                                  onPressed: () {
                                    setState(() {
                                      _texticon = 'Pinterest';
                                      _asseticon =
                                          'assets/iconcustom/iconnew/pinterest.png';
                                      _iconOption = false;
                                    });
                                  },
                                  child: Image.asset(
                                      'assets/iconcustom/iconnew/pinterest.png'),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color?>(
                                              white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        // side: BorderSide(color: Colors.red)
                                      ))),
                                  onPressed: () {
                                    setState(() {
                                      _texticon = 'Appstore';
                                      _asseticon =
                                          'assets/iconcustom/iconnew/appstore.png';
                                      _iconOption = false;
                                    });
                                  },
                                  child: Image.asset(
                                      'assets/iconcustom/iconnew/appstore.png'),
                                ),
                              ),
                              Container(
                                height: 60,
                                width: 60,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color?>(
                                              white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        // side: BorderSide(color: Colors.red)
                                      ))),
                                  onPressed: () {
                                    setState(() {
                                      _texticon = 'Chplay';
                                      _asseticon =
                                          'assets/iconcustom/iconnew/chplay.png';
                                      _iconOption = false;
                                    });
                                  },
                                  child: Image.asset(
                                      'assets/iconcustom/iconnew/chplay.png'),
                                ),
                              ),
                              Container(
                                height: 60,
                                width: 60,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color?>(
                                              white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        // side: BorderSide(color: Colors.red)
                                      ))),
                                  onPressed: () {
                                    setState(() {
                                      _texticon = 'Google';
                                      _asseticon =
                                          'assets/iconcustom/iconnew/google.png';
                                      _iconOption = false;
                                    });
                                  },
                                  child: Image.asset(
                                      'assets/iconcustom/iconnew/google.png'),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 40,
                          width: 180,
                          decoration: BoxDecoration(
                            border: Border.all(color: grey),
                            color: grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: _shapevalue == 1
                                        ? BoxShape.rectangle
                                        : BoxShape.circle,
                                    color: _shapeColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Body color',
                                  style: textType.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _iconOption = false;
                                      _shapeOption = !_shapeOption;
                                    });
                                  },
                                  icon: Icon(Icons.menu))
                            ],
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: _shapeOption ? 280 : 0,
                          width: 180,
                          child: SingleChildScrollView(
                              child: Container(
                            decoration: BoxDecoration(
                              color: blue.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 8,
                                ),
                                Text(
                                  'Body Color',
                                  style: textType,
                                ),
                                Container(
                                  height: 8,
                                ),
                                SlidePicker(
                                    showLabel: false,
                                    sliderSize: Size(160, 30),
                                    indicatorSize: Size(140, 30),
                                    pickerColor: _shapeColor,
                                    onColorChanged: (value) {
                                      setState(() {
                                        this._shapeColor = value;
                                      });
                                    }),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Square'),
                                        Radio(
                                            value: 1,
                                            groupValue: _shapevalue,
                                            onChanged: (val) {
                                              setState(() {
                                                _shapevalue = val!;
                                              });
                                            }),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Circle'),
                                        Radio(
                                            value: 2,
                                            groupValue: _shapevalue,
                                            onChanged: (val) {
                                              setState(() {
                                                _shapevalue = val!;
                                              });
                                            }),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 40,
                          width: 180,
                          decoration: BoxDecoration(
                            border: Border.all(color: grey),
                            color: grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: _eyevalue == 1
                                        ? BoxShape.rectangle
                                        : BoxShape.circle,
                                    color: _eyeColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Eye Shape',
                                  style: textType.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _iconOption = false;
                                      _eyeOption = !_eyeOption;
                                    });
                                  },
                                  icon: Icon(Icons.menu))
                            ],
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: _eyeOption ? 280 : 0,
                          width: 180,
                          child: SingleChildScrollView(
                              child: Container(
                            decoration: BoxDecoration(
                              color: blue.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 8,
                                ),
                                Text(
                                  'Eye Color',
                                  style: textType,
                                ),
                                Container(
                                  height: 8,
                                ),
                                SlidePicker(
                                    showLabel: false,
                                    sliderSize: Size(160, 30),
                                    indicatorSize: Size(140, 30),
                                    pickerColor: _eyeColor,
                                    onColorChanged: (value) {
                                      setState(() {
                                        this._eyeColor = value;
                                      });
                                    }),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Square'),
                                        Radio(
                                            value: 1,
                                            groupValue: _eyevalue,
                                            onChanged: (val) {
                                              setState(() {
                                                _eyevalue = val!;
                                              });
                                            }),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Circle'),
                                        Radio(
                                            value: 2,
                                            groupValue: _eyevalue,
                                            onChanged: (val) {
                                              setState(() {
                                                _eyevalue = val!;
                                              });
                                            }),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        texturl.text.toString().length > 0 ? blue : grey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.red)
                    ))),
                onPressed: texturl.text.toString().length > 0
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => IconQrPage(
                              titleType: 'Custom',
                              data: texturl.text.toString(),
                              typeicon: _texticon,
                              image: _asseticon,
                              shapeColor: _shapeColor,
                              shapevalue: _shapevalue,
                              eyeColor: _eyeColor,
                              eyevalue: _eyevalue,
                            ),
                          ),
                        );
                      }
                    : null,
                child: Container(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                        child: Text(
                      'Create',
                      style: textType,
                    ))),
              ),
            )
          ],
        ),
      ),
    );
  }

  void setText(String url) {
    texturl.value = TextEditingValue(
      text: texturl.text + url,
      selection: TextSelection.fromPosition(
        TextPosition(offset: (texturl.text + url).length),
      ),
    );
  }

  void deleteText() {
    texturl.value = TextEditingValue(
      text: '',
    );
  }
}
