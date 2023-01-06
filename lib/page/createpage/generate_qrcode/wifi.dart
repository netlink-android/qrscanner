import 'package:flutter/material.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/data/url_data.dart';
import '../../../const.dart';

class WifiPage extends StatefulWidget {
  const WifiPage({super.key});

  @override
  State<WifiPage> createState() => _WifiPageState();
}

enum TypeItem { WEP, WPA, No_encryption }

class _WifiPageState extends State<WifiPage> {
  TextEditingController textNetworkName = TextEditingController();
  String networkType = 'Network type';
  TextEditingController textPassword = TextEditingController();
  @override
  void initState() {
    textNetworkName = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    textPassword = TextEditingController()
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
        title: Text('Wifi'),
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
                    controller: textNetworkName,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.wifi,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              deleteText(textNetworkName);
                            });
                          },
                          icon: Icon(Icons.close_rounded)),
                      hintText: 'Enter name',
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
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(color: grey),
                      color: grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            networkType,
                            style: textType.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: networkType == 'Network type'
                                    ? black.withOpacity(0.6)
                                    : black),
                          ),
                        ),
                        PopupMenuButton<TypeItem>(
                            onSelected: (value) {
                              setState(() {
                                if (value == TypeItem.No_encryption) {
                                  networkType = 'Network type';
                                } else {
                                  networkType = value.name;
                                }
                              });

                              // if (value == MenuItem.item1) {
                              //   valueLanguage = value.toString();
                              // } else if (value == MenuItem.item2) {
                              // } else if (value == MenuItem.item2) {}
                            },
                            itemBuilder: (context) => const [
                                  PopupMenuItem(
                                    value: TypeItem.WEP,
                                    child: Text('WEP'),
                                  ),
                                  PopupMenuItem(
                                    value: TypeItem.WPA,
                                    child: Text('WPA/WPA2'),
                                  ),
                                  PopupMenuItem(
                                    value: TypeItem.No_encryption,
                                    child: Text('No encryption'),
                                  ),
                                ])
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: textPassword,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              deleteText(textPassword);
                            });
                          },
                          icon: Icon(Icons.close_rounded)),
                      hintText: 'Passwords',
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
                        (textNetworkName.text.toString().length > 0 &&
                                textPassword.text.toString().length > 0)
                            ? blue
                            : grey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.red)
                    ))),
                onPressed: (textNetworkName.text.toString().length > 0 &&
                        textPassword.text.toString().length > 0)
                    ? () {
                        String networkName = textNetworkName.text.toString();

                        String pass = textPassword.text.toString();

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => UrlQrPage(
                              titleType: 'Wifi',
                              data:
                                  'WIFI:S:$networkName;T:$networkType;P:$pass;H:false;;',
                              type: networkName,
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
