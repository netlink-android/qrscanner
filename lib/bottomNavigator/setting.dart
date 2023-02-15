import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/ads/banner.dart';
import 'package:qr_scanner/ads/native.dart';

import '../const.dart';
import '../them_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

enum MenuItem { English, VietNam, None }

class _SettingPageState extends State<SettingPage> {
  final switchData = GetStorage();
  bool isSwitched = false;

  bool isSound = false;
  String valueLanguage = 'English';
  @override
  void initState() {
    super.initState();
    if (switchData.read('isSwitched') != null) {
      setState(() {
        isSwitched = switchData.read('isSwitched');
      });
    }
    if (switchData.read('isSound') != null) {
      setState(() {
        isSound = switchData.read('isSound');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      // bottomNavigationBar:
      //     CustomBannerAd(idBanner: '/22486823495/sudoku_banner'),
      body: Column(
        children: [
          CustomBannerAd(idBanner: '/22486823495/sudoku_banner'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 16.0,
                left: 16,
                top: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Setting', style: textType),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 16.0,
                      left: 16,
                      top: 10,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color?>(blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            // side: BorderSide(color: Colors.red)
                          ))),
                      onPressed: () {},
                      child: Container(
                          width: double.infinity,
                          height: 50,
                          child: Center(
                              child: Text(
                            'Remove ads',
                            style: textType,
                          ))),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'General Setting',
                              style: textType.copyWith(
                                  color: blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
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
                                          Text(
                                            'Dark mode',
                                            style: textType.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      Switch.adaptive(
                                          value: isSwitched,
                                          onChanged: (value) {
                                            setState(() {
                                              // isSwitched = themeProvider.isDarkMode;
                                              isSwitched = value;

                                              final provider =
                                                  Provider.of<ThemeProvider>(
                                                      context,
                                                      listen: false);
                                              provider.toggleTheme(value);

                                              switchData.write(
                                                  'isSwitched', isSwitched);
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
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
                                          Text(
                                            'Beep',
                                            style: textType.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      Switch.adaptive(
                                          value: isSound,
                                          onChanged: (value) {
                                            setState(() {
                                              // isSwitched = themeProvider.isDarkMode;
                                              isSound = value;

                                              switchData.write(
                                                  'isSound', isSound);
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(bottom: 8.0),
                            //   child: Container(
                            //     height: 50,
                            //     decoration: BoxDecoration(
                            //       color: grey.withOpacity(0.5),
                            //       borderRadius: BorderRadius.circular(12),
                            //     ),
                            //     child: Padding(
                            //       padding: const EdgeInsets.symmetric(horizontal: 12),
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Row(
                            //             children: [
                            //               Text(
                            //                 'Languages',
                            //                 style: textType.copyWith(
                            //                     fontSize: 16,
                            //                     fontWeight: FontWeight.normal),
                            //               ),
                            //             ],
                            //           ),
                            //           Row(
                            //             children: [
                            //               Text(
                            //                 valueLanguage,
                            //                 style: textType.copyWith(
                            //                     fontSize: 16,
                            //                     fontWeight: FontWeight.bold),
                            //               ),
                            //               PopupMenuButton<MenuItem>(
                            //                   onSelected: (value) {
                            //                     setState(() {
                            //                       valueLanguage = value.name;
                            //                     });

                            //                     // if (value == MenuItem.item1) {
                            //                     //   valueLanguage = value.toString();
                            //                     // } else if (value == MenuItem.item2) {
                            //                     // } else if (value == MenuItem.item2) {}
                            //                   },
                            //                   itemBuilder: (context) => const [
                            //                         PopupMenuItem(
                            //                           value: MenuItem.English,
                            //                           child: Text(
                            //                             'English',
                            //                             style: TextStyle(
                            //                                 fontWeight:
                            //                                     FontWeight.bold),
                            //                           ),
                            //                         ),
                            //                         PopupMenuItem(
                            //                           value: MenuItem.VietNam,
                            //                           child: Text(
                            //                             'VietNam',
                            //                             style: TextStyle(
                            //                                 fontWeight:
                            //                                     FontWeight.bold),
                            //                           ),
                            //                         ),
                            //                         PopupMenuItem(
                            //                           value: MenuItem.None,
                            //                           child: Text(
                            //                             'None',
                            //                             style: TextStyle(
                            //                                 fontWeight:
                            //                                     FontWeight.bold),
                            //                           ),
                            //                         ),
                            //                       ])
                            //             ],
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            NativeAdManager(
                              idNative: '/22486823495/sudoku_native',
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Help',
                              style: textType.copyWith(
                                  color: blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  print('FAQ');
                                  HapticFeedback.vibrate();
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
                                        Text(
                                          'FAQ',
                                          style: textType.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  print('Policy');
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
                                        Text(
                                          'Privacy policy',
                                          style: textType.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  print('Share');
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
                                        Text(
                                          'Share App',
                                          style: textType.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  print('Rate App');
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
                                        Text(
                                          'Rate App',
                                          style: textType.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
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
                                      Text(
                                        'Version 1.0.0',
                                        style: textType.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
