import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DialogColor {
  static pickerColor(context) =>
      showDialog(context: context, builder: (context) => PickColor());
}

class PickColor extends StatefulWidget {
  const PickColor({super.key});

  @override
  State<PickColor> createState() => _PickColorState();
}

class _PickColorState extends State<PickColor> {
  Color color = Colors.red;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
            title: Text('PickColor'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ColorPicker(
                    showLabel: false,
                    pickerColor: color,
                    onColorChanged: (value) {
                      
                      setState(() {
                        this.color = value;
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
          );
  }
}
