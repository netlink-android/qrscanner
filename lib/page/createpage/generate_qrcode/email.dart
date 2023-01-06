import 'package:flutter/material.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/data/url_data.dart';
import '../../../const.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  TextEditingController textEmail = TextEditingController();
  TextEditingController textSublect = TextEditingController();
  TextEditingController textMessage = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    textEmail = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email'),
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
                    controller: textEmail,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              deleteText(textEmail);
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        height: 35,
                        width: 80,
                        decoration: BoxDecoration(
                          color: blue.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  setText('.gmail');
                                });
                              },
                              child: Text(
                                '@gmail',
                                style: textType.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        height: 35,
                        width: 70,
                        decoration: BoxDecoration(
                          color: blue.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  setText('.com');
                                });
                              },
                              child: Text(
                                '.com',
                                style: textType.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              )),
                        ),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 70,
                      decoration: BoxDecoration(
                        color: blue.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                setText('.vn');
                              });
                            },
                            child: Text(
                              '.vn',
                              style: textType.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                            )),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: textSublect,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                deleteText(textSublect);
                              });
                            },
                            icon: Icon(Icons.close_rounded)),
                        hintText: 'Subject Of  Email',
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
                Container(
                  decoration: BoxDecoration(
                    color: grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: textMessage,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              deleteText(textMessage);
                            });
                          },
                          icon: Icon(Icons.close_rounded)),
                      hintText: 'Message',
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        textEmail.text.toString().length > 0 ? blue : grey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.red)
                    ))),
                onPressed: textEmail.text.toString().length > 0
                    ? () {
                        String email = textEmail.text.toString();
                        String sublect = textSublect.text.toString();
                        String message = textMessage.text.toString();

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => UrlQrPage(
                              titleType: 'Email',
                              data:
                                  'MATMSG:TO:$email;SUB:$sublect;BODY:$message;;',
                              type: email,
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
    textEmail.value = TextEditingValue(
      text: textEmail.text + url,
      selection: TextSelection.fromPosition(
        TextPosition(offset: (textEmail.text + url).length),
      ),
    );
  }

  void deleteText(TextEditingController textDelete) {
    textDelete.value = TextEditingValue(
      text: '',
    );
  }
}
