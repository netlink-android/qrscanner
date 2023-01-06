import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/data/url_data.dart';
import '../../../const.dart';

class SmsPage extends StatefulWidget {
  const SmsPage({super.key});

  @override
  State<SmsPage> createState() => _SmsPageState();
}

enum TypeItem { WEP, WPA, No_encryption }

class _SmsPageState extends State<SmsPage> {
  TextEditingController textPhone = TextEditingController();
  TextEditingController textMessage = TextEditingController();
  String countryCode = '';
  @override
  void initState() {
    textPhone = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    textMessage = TextEditingController()
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
        title: Text('SMS'),
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
                  child: IntlPhoneField(
                    disableLengthCheck: true,
                    controller: textPhone,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.call,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              deleteText(textPhone);
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: textMessage,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.sms,
                        ),
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
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(
                        (textPhone.text.toString().length > 0 &&
                                textMessage.text.toString().length > 0)
                            ? blue
                            : grey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.red)
                    ))),
                onPressed: (textPhone.text.toString().length > 0 &&
                        textMessage.text.toString().length > 0)
                    ? () {
                        String phone = textPhone.text.toString();

                        String mess = textMessage.text.toString();

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => UrlQrPage(
                              titleType: 'SMS',
                              data: 'SMSTO:$phone:$mess',
                              type: phone,
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
