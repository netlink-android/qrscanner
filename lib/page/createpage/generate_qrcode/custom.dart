import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../const.dart';

class CustomPageQr extends StatefulWidget {
  const CustomPageQr({super.key});

  @override
  State<CustomPageQr> createState() => _CustomPageQrState();
}

class _CustomPageQrState extends State<CustomPageQr> {
  Color colorBody = black;
  Color colorEye = black;
  int _valueShape = 1;

  @override
  void setState(VoidCallback fn) {
    _valueShape = 1;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        height: 30,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: colorBody),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Body Shape',
                          style: textType.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: black),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              pickColor(context, colorBody);
                              
                            });
                          },
                          icon: Icon(Icons.menu))
                    ],
                  ),
                ),
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
                        height: 30,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: colorEye),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Eye Shape',
                          style: textType.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: black),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              pickColor(context, colorEye);
                            });
                          },
                          icon: Icon(Icons.menu))
                    ],
                  ),
                ),
              ],
            ),
            Container(
              color: white,
              child: QrImage(
                data: 'tel:456',
                version: QrVersions.auto,
                size: 250,
                // foregroundColor: Colors.red,
                embeddedImage:
                    AssetImage('assets/iconcustom/iconnew/facebook.png'),
                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: Size(50, 50),
                ),
                eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.square, color: Colors.red),
                dataModuleStyle: const QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.circle,
                    color: Colors.green),
                // gapless: false,
                errorStateBuilder: (cxt, err) {
                  return Container(
                    child: Center(
                      child: Text(
                        "Uh oh! Something went wrong...",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Text('Square'),
                    Radio(
                        value: 1,
                        groupValue: _valueShape,
                        onChanged: (val) {
                          setState(() {
                            _valueShape = val!;
                          });
                        }),
                  ],
                ),
                Row(
                  children: [
                    Text('Circle'),
                    Radio(
                        value: 2,
                        groupValue: _valueShape,
                        onChanged: (val) {
                          setState(() {
                            _valueShape = val!;
                          });
                        }),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void pickColor(BuildContext context, color) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Body Shape', style: textType),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Color',
                  style: textType.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 8,
                ),
                SlidePicker(
                    showLabel: false,
                    pickerColor: color,
                    onColorChanged: (value) {
                      setState(() {
                        ColorPick colorPick = new ColorPick();
                        color = value;
                        colorPick.age;
                      });
                    }),
              ],
            ),
          ));
}

class ColorPick {
  Color color = black;

  Color get age {
    return color;
  }

  void set age(Color currentYear) {
    color = currentYear;
  }
}
