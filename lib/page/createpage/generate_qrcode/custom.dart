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
  Color color = black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          height: 40,
          width: 150,
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
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Color',
                  style: textType.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: black),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      pickColor(context);
                    });
                  },
                  icon: Icon(Icons.menu))
            ],
          ),
        ),
      ),
    );
  }

  void pickColor(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('PickColor'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ColorPicker(
                    showLabel: false,
                    pickerColor: color,
                    onColorChanged: (color) {
                      setState(() {
                        this.color = color;
                      });
                    }),
                // TextButton(
                //   child: Text('Select'),
                //   onPressed: () {
                //     Navigator.of(context).pop();
                //   },
                // ),
              ],
            ),
          ));
}
