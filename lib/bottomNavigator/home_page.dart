import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/const.dart';

import '../page/homepage/dataQr_page.dart';
import '../page/homepage/qr_over.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  MobileScannerController controller = new MobileScannerController();
  double zoom = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: IconButton(
                          onPressed: () {
                            
                          },
                          icon:Icon(Icons.flash_off),
                        ),
                        decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Qr Scanner',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            // padding: const EdgeInsets.all(6),
                            child: IconButton(
                                onPressed: () {

                                },
                                icon: Icon(Icons.upload_file, size: 35)),
                            decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                    
                            child: IconButton(
                                onPressed: ()  {
                                  
                                },
                                icon: Icon(Icons.cameraswitch_sharp, size: 35)),
                            decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                MobileScanner(
                    controller: controller,
                    // fit: FittedSizes,
                    allowDuplicates: false,
                    onDetect: (barcode, args) {
                      if (barcode.rawValue == null) {
                        debugPrint('Failed to scan Barcode');
                      } else {
                        BarcodeType type = barcode.type;
                        print(type.name);
                        final String code = barcode.rawValue!;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => DataQrPage(
                              data: code,
                            ),
                          ),
                        );
                        debugPrint('Barcode found! $code');
                      }
                    }),
                QRScannerOverlay(
                  overlayColour: Colors.black.withOpacity(0.8),
                  zoom: zoom,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                      widthFactor: double.infinity,
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (zoom > 1) {
                                    zoom -= 0.1;
                                  } else if (zoom == 1) {
                                    zoom = zoom;
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.strikethrough_s,
                                color: Colors.white,
                                size: 50,
                              )),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (zoom < 1.6) {
                                    zoom += 0.1;
                                  } else if (zoom == 1.6) {
                                    zoom = zoom;
                                  }
                                  
                                });
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 50,
                              )),
                        ],
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
