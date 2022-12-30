import 'package:flutter/material.dart';
import 'package:qr_scanner/const.dart';

class VcardPage extends StatefulWidget {
  const VcardPage({super.key});

  @override
  State<VcardPage> createState() => _VcardPageState();
}

class _VcardPageState extends State<VcardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Text(
        'V-card',
        style: textType,
      )),
    );
  }
}
