import 'package:flutter/material.dart';
import 'package:qr_scanner/const.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  bool _indexOne = false,
      _indexTwo = false,
      _indexThree = false,
      _indexFour = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'FAQ',
          style: textType,
        )),
        body: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    height: _indexOne ? 175 : 55,
                    decoration: BoxDecoration(
                      color: grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.qr_code),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Code can't be read?",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: textType.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _indexOne = !_indexOne;
                                  });
                                },
                                icon: Icon(_indexOne
                                    ? Icons.arrow_circle_up
                                    : Icons.arrow_circle_down))
                          ],
                        ),
                        Container(
                          child: _indexOne
                              ? AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  height: _indexOne ? 120 : 0,
                                  child: SingleChildScrollView(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "1. If you are using a low-end phone, scanning may be very difficult or even impossible due to the low camera quality. \nYou could try to take a photo with your camera app, then open our app and tap 'Scan from the gallery' to solve this problem.\n2. If you still can't get the result when scanning the barcode or QR code, you can reboot app or please send an email via feedback to us, we will solve the problem for you as soon as possible.",
                                        style: textType.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  )),
                                )
                              : null,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    height: _indexTwo ? 125 : 55,
                    decoration: BoxDecoration(
                      color: grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.dashboard_customize_outlined),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "How to generate Qr code",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: textType.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _indexTwo = !_indexTwo;
                                  });
                                },
                                icon: Icon(_indexTwo
                                    ? Icons.arrow_circle_up
                                    : Icons.arrow_circle_down))
                          ],
                        ),
                        Container(
                          child: _indexTwo
                              ? AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  height: _indexTwo ? 70 : 0,
                                  child: SingleChildScrollView(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "1. You open the Create tab in the application\n2. Here we provide you you can generate qr code in a lot of formats.",
                                        style: textType.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  )),
                                )
                              : null,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    height: _indexThree ? 85 : 55,
                    decoration: BoxDecoration(
                      color: grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.wifi),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Can't connect to Wifi",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: textType.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _indexThree = !_indexThree;
                                  });
                                },
                                icon: Icon(_indexThree
                                    ? Icons.arrow_circle_up
                                    : Icons.arrow_circle_down))
                          ],
                        ),
                        Container(
                          child: _indexThree
                              ? AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  height: _indexThree ? 30 : 0,
                                  child: SingleChildScrollView(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'The function will be launhcher soon...!',
                                        style: textType.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  )),
                                )
                              : null,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
