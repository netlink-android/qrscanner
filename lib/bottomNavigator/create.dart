import 'package:flutter/material.dart';
import 'package:qr_scanner/const.dart';
import 'package:qr_scanner/page/createpage/createCustom.dart';
import 'package:qr_scanner/page/createpage/create_history/qrcreated_history.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Qr Create', style: textType),
          SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              setState(() {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => QrCreatedHistory(),
                  ),
                );
              });
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_filled_rounded,
                          size: 30,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Qr Created History',
                          style: textType.copyWith(fontSize: 18),
                        )
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
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              children: [
                CreateCustomPage(type: 'URL', icontype: 'link.png'),
                CreateCustomPage(type: 'Email', icontype: 'email.png'),
                CreateCustomPage(type: 'Text', icontype: 'text.png'),
                CreateCustomPage(type: 'Call', icontype: 'call.png'),
                CreateCustomPage(type: 'Wifi', icontype: 'wifi.png'),
                CreateCustomPage(type: 'SMS', icontype: 'sms.png'),
                CreateCustomPage(type: 'V-card', icontype: 'card.png'),
                CreateCustomPage(type: 'Location', icontype: 'location.png'),
                CreateCustomPage(type: 'Social', icontype: 'social.png'),
                CreateCustomPage(type: 'Custom', icontype: 'add.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
