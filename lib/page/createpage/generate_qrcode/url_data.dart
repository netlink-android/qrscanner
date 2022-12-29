import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/const.dart';

class UrlQrPage extends StatefulWidget {
  String data = '';
  UrlQrPage({Key? key, required this.data}) : super(key: key);

  @override
  State<UrlQrPage> createState() => _UrlQrPageState();
}

class _UrlQrPageState extends State<UrlQrPage> {
  bool favorite = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 35,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 15,
                      ),
                      Text(
                        'URL',
                        style: textType,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            favorite = !favorite;
                            toastFavorite();
                          });
                        },
                        icon: favorite
                            ? Icon(
                                Icons.star,
                                size: 35,
                                color: red,
                              )
                            : Icon(
                                Icons.star_border_outlined,
                                size: 35,
                              )),
                  )
                ],
              ),
            ),
            Container(
              height: 280,
              width: double.infinity,
              color: blue.withOpacity(0.3),
              child: Center(
                child: Container(
                  color: white,
                  child: QrImage(
                    data: widget.data,
                    version: QrVersions.auto,
                    size: 250,
                    // foregroundColor: Colors.red,
                    // embeddedImage: NetworkImage(
                    //     'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
                    // embeddedImageStyle: QrEmbeddedImageStyle(
                    //   size: Size(80, 80),
                    // ),
                    // eyeStyle:
                    //     const QrEyeStyle(eyeShape: QrEyeShape.circle, color: Colors.red),
                    // dataModuleStyle: const QrDataModuleStyle(
                    //     dataModuleShape: QrDataModuleShape.circle, color: Colors.green),
                    // gapless: false,
                    // errorStateBuilder: (cxt, err) {
                    //   return Container(
                    //     child: Center(
                    //       child: Text(
                    //         "Uh oh! Something went wrong...",
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //   );
                    // },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toastFavorite() {
    if (favorite) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Added to Favorites"),
        duration: Duration(milliseconds: 400),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Deleted to Favorites"),
        duration: Duration(milliseconds: 400),
      ));
    }
  }
}
