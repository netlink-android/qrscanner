//https://maps.google.com/local?q=53.09164029206792,61.84474427734375
import 'package:flutter/material.dart';
import 'package:qr_scanner/page/createpage/generate_qrcode/url_data.dart';
import '../../../const.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

enum TypeItem { WEP, WPA, No_encryption }

class _LocationPageState extends State<LocationPage> {
  TextEditingController textLatitude = TextEditingController();

  TextEditingController textLongitude = TextEditingController();
  @override
  void initState() {
    textLatitude = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    textLongitude = TextEditingController()
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
        title: Text('Location'),
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
                    controller: textLatitude,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_on,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              deleteText(textLatitude);
                            });
                          },
                          icon: Icon(Icons.close_rounded)),
                      hintText: 'Latitude',
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
                      controller: textLongitude,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_on_outlined,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                deleteText(textLongitude);
                              });
                            },
                            icon: Icon(Icons.close_rounded)),
                        hintText: 'Longitude',
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
                        (textLatitude.text.toString().length > 0 &&
                                textLongitude.text.toString().length > 0)
                            ? blue
                            : grey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.red)
                    ))),
                onPressed: (textLatitude.text.toString().length > 0 &&
                        textLongitude.text.toString().length > 0)
                    ? () {
                        String latitude = textLatitude.text.toString();

                        String longitude = textLongitude.text.toString();

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => UrlQrPage(
                              titleType: 'Location',
                              data:
                                  'https://maps.google.com/local?q=$longitude,$latitude',
                              type: 'Latitude: $latitude' + ' - ' + 'Longitude: $longitude',
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
