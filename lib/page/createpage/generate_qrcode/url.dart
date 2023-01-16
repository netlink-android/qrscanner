import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/data/url_data.dart';

import '../../../const.dart';

class UrlPage extends StatefulWidget {
  const UrlPage({super.key});

  @override
  State<UrlPage> createState() => _UrlPageState();
}

class _UrlPageState extends State<UrlPage> {
  TextEditingController texturl = TextEditingController();
  final _newValue = "http://";

  @override
  void initState() {
    // TODO: implement initState

    texturl = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    setText(_newValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Url'),
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
                        Icons.link,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
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
                Container(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        height: 35,
                        width: 70,
                        decoration: BoxDecoration(
                          color: blue.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  setText('www');
                                });
                              },
                              child: Text(
                                'www',
                                style: textType.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        height: 35,
                        width: 70,
                        decoration: BoxDecoration(
                          color: blue.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  setText('.com');
                                });
                              },
                              child: Text(
                                '.com',
                                style: textType.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              )),
                        ),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 70,
                      decoration: BoxDecoration(
                        color: blue.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                setText('.vn');
                              });
                            },
                            child: Text(
                              '.vn',
                              style: textType.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                            )),
                      ),
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
                            builder: (ctx) => UrlQrPage(
                              titleType: 'URL',
                              data: texturl.text.toString(),
                              type: texturl.text.toString(),
                               typeicon: 'assets/iconcustom/link.png',
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
