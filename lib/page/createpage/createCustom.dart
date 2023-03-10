import 'package:flutter/material.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/call.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/custom.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/email.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/sms.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/social.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/text.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/url.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/v-card.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/wifi.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/zoom.dart';

import '../../ads/interstitial.dart';
import '../../const.dart';
import 'generate_qrcode/calendar.dart';
import 'generate_qrcode/location.dart';

class CreateCustomPage extends StatefulWidget {
  String type;
  String icontype;
  CreateCustomPage({Key? key, required this.type, required this.icontype})
      : super(key: key);

  @override
  State<CreateCustomPage> createState() => _CreateCustomPageState();
}

class _CreateCustomPageState extends State<CreateCustomPage> {
  InterstitialAdManager? interstitialAdManager;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    interstitialAdManager =
        InterstitialAdManager('/22486823495/sudoku_iterstitial')
          ..loadInterstitial();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color?>(blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    // side: BorderSide(color: Colors.red)
                  ))),
              onPressed: () {
                print(widget.type);
                setState(() {
                  interstitialAdManager!.showInterstitial(context, _pageQr());
                });
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (ctx) => _pageQr(),
                //   ),
                // );
              },
              child: Image.asset('assets/iconcustom/' + widget.icontype)),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          widget.type,
          style: textType.copyWith(fontSize: 18, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }

  Widget _pageQr() {
    List<Widget> _generateQr = [
      UrlPage(),
      EmailPage(),
      TextPage(),
      CallPage(),
      WifiPage(),
      SmsPage(),
      LocationPage(),
      // VcardPage(),
      // CalendarPage(),
      ZoomPage(),
      SocialPage(typeImage: widget.type),
      CustomPageQr(),
    ];

    List<String> _typeQr = [
      'URL',
      'Email',
      'Text',
      'Call',
      'Wifi',
      'SMS',
      'Location',
      // 'V-card',
      // 'Calendar',
      'Zoom',
      'Social',

      'Custom',
      // 'Custom',
    ];
    int index = 8;
    for (int i = 0; i < _generateQr.length; i++) {
      if (widget.type == _typeQr[i]) {
        index = i;
      }
    }
    return _generateQr[index];
  }
}
