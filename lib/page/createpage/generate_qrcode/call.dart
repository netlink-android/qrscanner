import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/url_data.dart';

import '../../../const.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  TextEditingController textCall = TextEditingController();
  String countryCode = '';
  @override
  void initState() {
    // TODO: implement initState
    textCall = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //     color: grey.withOpacity(0.5),
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   child: TextField(
                //     controller: textCall,
                //     keyboardType: TextInputType.number,
                //     decoration: InputDecoration(
                //       prefixIcon: Icon(
                //         Icons.call,
                //       ),
                //       suffixIcon: IconButton(
                //           onPressed: () {
                //             setState(() {
                //               deleteText();
                //             });
                //           },
                //           icon: Icon(Icons.close_rounded)),
                //       hintText: 'Please enter number',
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(12),
                //         borderSide: BorderSide(color: grey, width: 2),
                //       ),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(12),
                //         borderSide: BorderSide(color: black),
                //       ),
                //     ),
                //   ),
                // ),
                // Container(
                //   height: 10,
                // ),
                Container(
                  decoration: BoxDecoration(
                    color: grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IntlPhoneField(
                    disableLengthCheck: true,
                    controller: textCall,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.call,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              deleteText();
                            });
                            FocusScope.of(context).unfocus();
                          },
                          icon: Icon(Icons.close_rounded)),
                      hintText: 'Please enter number',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: grey, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: black),
                      ),
                    ),
                    onChanged: (phone) {
                      countryCode = phone.completeNumber;
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ' + country.name);
                    },
                    initialCountryCode: 'VN',
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        textCall.text.toString().length > 0 ? blue : grey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.red)
                    ))),
                onPressed: textCall.text.toString().length > 0
                    ? () {
                        String number = countryCode + textCall.text.toString();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => UrlQrPage(
                              titleType: 'Call',
                              data: 'tel:$countryCode',
                              type: countryCode,
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
    textCall.value = TextEditingValue(
      text: textCall.text + url,
      selection: TextSelection.fromPosition(
        TextPosition(offset: (textCall.text + url).length),
      ),
    );
  }

  void deleteText() {
    textCall.value = TextEditingValue(
      text: '',
    );
  }
}
