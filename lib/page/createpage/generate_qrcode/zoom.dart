//https://maps.google.com/local?q=53.09164029206792,61.84474427734375
import 'package:flutter/material.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/data/url_data.dart';
import '../../../const.dart';

class ZoomPage extends StatefulWidget {
  const ZoomPage({super.key});

  @override
  State<ZoomPage> createState() => _ZoomPageState();
}

class _ZoomPageState extends State<ZoomPage> {
  TextEditingController textMeetId = TextEditingController();

  TextEditingController textPass = TextEditingController();
  @override
  void initState() {
    textMeetId = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    textPass = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Zoom'),
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
                    controller: textMeetId,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.format_list_numbered_sharp,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              deleteText(textMeetId);
                            });
                          },
                          icon: Icon(Icons.close_rounded)),
                      hintText: 'Meeting ID',
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
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: textPass,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.password,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                deleteText(textPass);
                              });
                            },
                            icon: Icon(Icons.close_rounded)),
                        hintText: 'Password',
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
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        (textMeetId.text.toString().length > 0 &&
                                textPass.text.toString().length > 0)
                            ? blue
                            : grey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.red)
                    ))),
                onPressed: (textMeetId.text.toString().length > 0 &&
                        textPass.text.toString().length > 0)
                    ? () {
                        String meetId = textMeetId.text.toString();

                        String textPa = textPass.text.toString();

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => UrlQrPage(
                              titleType: 'Zoom',
                              data: 'https://zoom.us/j/$meetId?pwd=$textPa',
                              type: 'Zoom id: $meetId',
                              typeicon: 'assets/iconcustom/iconnew/zoom.png',
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

  void deleteText(TextEditingController textDelete) {
    textDelete.value = TextEditingValue(
      text: '',
    );
  }
}
