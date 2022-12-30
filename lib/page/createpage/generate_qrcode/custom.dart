import 'package:flutter/material.dart';

import '../../../const.dart';

class CustomPageQr extends StatefulWidget {
  const CustomPageQr({super.key});

  @override
  State<CustomPageQr> createState() => _CustomPageQrState();
}

class _CustomPageQrState extends State<CustomPageQr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Text(
        'Custom',
        style: textType,
      )),
    );
    ;
  }
}
