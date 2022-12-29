import 'package:flutter/material.dart';
import 'package:qr_scanner/main.dart';

import '../../bottomNavigator/home_page.dart';

class DataQrPage extends StatefulWidget {
  String data;
  DataQrPage({Key? key, required this.data}) : super(key: key);

  @override
  State<DataQrPage> createState() => _DataQrPageState();
}

class _DataQrPageState extends State<DataQrPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => MainPage(),
                ),
              );
          // Navigator.of(context).pop();
          },
          ),
          ),
      body: Center(
        child: Text(widget.data),
      ),
    );
    ;
  }
}
