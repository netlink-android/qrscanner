import 'package:flutter/material.dart';

class DataQrPage extends StatefulWidget {
  String data;
   DataQrPage({Key? key, required this.data}) : super(key:key);

  @override
  State<DataQrPage> createState() => _DataQrPageState();
}

class _DataQrPageState extends State<DataQrPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        // leading: IconButton(icon: Icon(Icons.arrow_back),
        // onPressed: (){
        //   Navigator.of(context).push(
        //           MaterialPageRoute(
        //             builder: (ctx) => MobileScannerPage(),
        //           ),
        //         );
        // },),
      ),
      body: Center(
        child: Text(widget.data),
      ),
    );;
  }
}