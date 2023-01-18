// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:qr_scanner/const.dart';

// import '../page/homepage/dataQr_page.dart';
// import '../page/homepage/qr_over.dart';

// class ScanQrPage extends StatefulWidget {
//   const ScanQrPage({super.key});

//   @override
//   State<ScanQrPage> createState() => _ScanQrPageState();
// }

// class _ScanQrPageState extends State<ScanQrPage> {
//   MobileScannerController controller = new MobileScannerController();
//   double zoom = 1;
//   int indexTop = 0;
//   double valueBottom = 20;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   child: IconButton(
//                     onPressed: () {
//                       setState(() {
//                         controller.toggleTorch();
//                       });
//                       // print(controller.torchState.value);
//                     },
//                     icon: controller.torchState.value == TorchState.on
//                         ? Icon(Icons.flash_on, size: 25)
//                         : Icon(Icons.flash_off, size: 25),
//                   ),
//                   decoration: BoxDecoration(
//                     color: blue,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   'Qr Scanner',
//                   style: textType,
//                 ),
//                 Row(
//                   children: [
//                     Container(
//                       // padding: const EdgeInsets.all(6),
//                       child: IconButton(
//                           onPressed: () {},
//                           icon: Icon(Icons.upload_file, size: 25)),
//                       decoration: BoxDecoration(
//                         color: blue,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Container(
//                       child: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               controller.switchCamera();
//                             });
//                           },
//                           icon: Icon(Icons.cameraswitch_sharp, size: 25)),
//                       decoration: BoxDecoration(
//                         color: blue,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 4,
//             child: Stack(
//               children: [

//                 MobileScanner(
//                     fit: BoxFit.cover,
//                     controller: controller,
//                     allowDuplicates: false,
//                     onDetect: (barcode, args) {
//                       if (barcode.rawValue == null) {
//                         debugPrint('Failed to scan Barcode');
//                       } else {
//                         BarcodeType type = barcode.type;
//                         print(type.name);
//                         final String code = barcode.rawValue!;
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (ctx) => DataQrPage(
//                               data: code,
//                             ),
//                           ),
//                         );
//                         debugPrint('Barcode found! $code');
//                       }
//                     }),

//                 // QRScannerOverlay(
//                 //   overlayColour: Colors.black.withOpacity(0.5),
//                 //   zoom: zoom,
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.all(20.0),
//                 //   child: Align(
//                 //       widthFactor: double.infinity,
//                 //       alignment: Alignment.bottomRight,
//                 //       child: Row(
//                 //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //         children: [
//                 //           IconButton(
//                 //               onPressed: () {
//                 //                 setState(() {
//                 //                   if (zoom > 1) {
//                 //                     zoom -= 0.1;
//                 //                   } else if (zoom == 1) {
//                 //                     zoom = zoom;
//                 //                   }
//                 //                 });
//                 //               },
//                 //               icon: Icon(
//                 //                 Icons.strikethrough_s,
//                 //                 color: Colors.white,
//                 //                 size: 50,
//                 //               )),

//                 //           IconButton(
//                 //               onPressed: () {
//                 //                 setState(() {
//                 //                   if (zoom < 1.6) {
//                 //                     zoom += 0.1;
//                 //                   } else if (zoom == 1.6) {
//                 //                     zoom = zoom;
//                 //                   }
//                 //                 });
//                 //               },
//                 //               icon: Icon(
//                 //                 Icons.add,
//                 //                 color: Colors.white,
//                 //                 size: 50,
//                 //               )),
//                 //           // buildSliderTopLabel(),
//                 //         ],
//                 //       )),
//                 // )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildSliderTopLabel() {
//     final labels = ['-', '18', '30', '50', '+'];
//     final double min = 0;
//     final double max = labels.length - 1.0;
//     final divisions = labels.length - 1;

//     return Column(
//       children: [
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: Utils.modelBuilder(
//               labels,
//               (index, label) {
//                 final selectedColor = white;
//                 final unselectedColor = Colors.white.withOpacity(0.3);
//                 final isSelected = index <= indexTop;
//                 final color = isSelected ? selectedColor : unselectedColor;

//                 return buildLabel(label: label, color: color, width: 30);
//               },
//             ),
//           ),
//         ),
//         Slider(
//           value: indexTop.toDouble(),
//           min: min,
//           max: max,
//           divisions: divisions,
//           activeColor: white,
//           inactiveColor: red,
//           // label: labels[indexTop],
//           onChanged: (value) => setState(() => this.indexTop = value.toInt()),
//         ),
//       ],
//     );
//   }

//   Widget buildLabel({
//     required String label,
//     required double width,
//     required Color color,
//   }) =>
//       Container(
//         width: width,
//         child: Text(
//           label,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ).copyWith(color: color),
//         ),
//       );

//   Widget buildSideLabel(double value) => Container(
//         width: 25,
//         child: Text(
//           value.round().toString(),
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       );
// }

// class Utils {
//   static List<Widget> modelBuilder<M>(
//           List<M> models, Widget Function(int index, M model) builder) =>
//       models
//           .asMap()
//           .map<int, Widget>(
//               (index, model) => MapEntry(index, builder(index, model)))
//           .values
//           .toList();
// }

//********************************************************* */
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner/const.dart';

import '../page/homepage/dataQr_page.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  double zoom = 1;
  int indexTop = 0;
  bool codeState = false;

  //Qr scanner
  Barcode? result;
  String data = '';
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  void reassemble() {
    setState(() {
      controller!.resumeCamera();
    });
    super.reassemble();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: IconButton(
                    onPressed: () async {
                      await controller?.toggleFlash();
                      setState(() {});
                      // print(controller.torchState.value);
                    },
                    icon: FutureBuilder(
                      future: controller?.getFlashStatus(),
                      builder: (context, snapshot) {
                        return Icon(
                          snapshot.data == true
                              ? Icons.flash_on
                              : Icons.flash_off,
                          size: 25,
                        );
                      },
                    ),
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
                  style: textType,
                ),
                Row(
                  children: [
                    Container(
                      // padding: const EdgeInsets.all(6),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.upload_file, size: 25)),
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      child: IconButton(
                          onPressed: () async {
                            await controller?.flipCamera();
                            setState(() {});
                          },
                          icon: Icon(Icons.cameraswitch_sharp, size: 25)),
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
          // Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                _buildQrView(context),
                Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: codeState ? 265 : 0,
                    width: codeState ? 300 : 0,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: white,
                      boxShadow: [
                        BoxShadow(
                            color: black.withOpacity(0.2),
                            offset: Offset.zero,
                            spreadRadius: 5,
                            blurRadius: 10)
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          codeState = false;
                                          controller!.resumeCamera();
                                        });
                                      },
                                      icon: Icon(
                                        Icons.close_sharp,
                                        size: 40,
                                        color: red,
                                      )),
                                ],
                              ),
                              Center(
                                  child: Text(
                                'Data: $data',
                                style: textType.copyWith(fontSize: 20),
                              )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (ctx) => DataQrPage(
                                            titleType: 'Data',
                                            data: result!.code.toString(),
                                            type: result!.code.toString(),
                                            typeicon:
                                                'assets/iconcustom/iconnew/noicon.png')));
                                  },
                                  child: Row(
                                    children: [
                                      Text('View'),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Icon(
                                            Icons.arrow_circle_right_outlined),
                                      )
                                    ],
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(20.0),
                //   child: Align(
                //       widthFactor: double.infinity,
                //       alignment: Alignment.bottomRight,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           IconButton(
                //               onPressed: () {
                //                 setState(() {
                //                   if (zoom > 1) {
                //                     zoom -= 0.1;
                //                   } else if (zoom == 1) {
                //                     zoom = zoom;
                //                   }
                //                 });
                //               },
                //               icon: Icon(
                //                 Icons.strikethrough_s,
                //                 color: Colors.white,
                //                 size: 50,
                //               )),

                //           IconButton(
                //               onPressed: () {
                //                 setState(() {
                //                   if (zoom < 1.6) {
                //                     zoom += 0.1;
                //                   } else if (zoom == 1.6) {
                //                     zoom = zoom;
                //                   }
                //                 });
                //               },
                //               icon: Icon(
                //                 Icons.add,
                //                 color: Colors.white,
                //                 size: 50,
                //               )),
                //           // buildSliderTopLabel(),
                //         ],
                //       )),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 400.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 5,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      data = result!.code.toString();

      setState(() {
        codeState = true;
        // _showMyDialog();
      });
      // setState(() {
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (ctx) => DataQrPage(
      //           titleType: 'Data',
      //           data: result!.code.toString(),
      //           type: result!.code.toString(),
      //           typeicon: 'assets/iconcustom/iconnew/noicon.png')));
      // });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
