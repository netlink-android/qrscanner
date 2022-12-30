import 'package:flutter/material.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/url_data.dart';

import '../../../const.dart';

class TextPage extends StatefulWidget {
  const TextPage({super.key});

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  TextEditingController texturl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    texturl = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: texturl,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.text_fields_outlined,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              deleteText();
                            });
                          },
                          icon: Icon(Icons.close_rounded)),
                      hintText: 'Please enter text',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: grey, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: black),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 10,
                ),
                
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        texturl.text.toString().length > 0 ? blue : grey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.red)
                    ))),
                onPressed: texturl.text.toString().length > 0
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => UrlQrPage(
                              titleType: 'Text',
                              data: texturl.text.toString(),
                              type: texturl.text.toString(),
                            ),
                          ),
                        );
                      }
                    : null,
                child: Container(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                        child: Text(
                      'Create',
                      style: textType,
                    ))),
              ),
            )
          ],
        ),
      ),
    );
  }

  void setText(String url) {
    texturl.value = TextEditingValue(
      text: texturl.text + url,
      selection: TextSelection.fromPosition(
        TextPosition(offset: (texturl.text + url).length),
      ),
    );
  }

  void deleteText() {
    texturl.value = TextEditingValue(
      text: '',
    );
  }
}
