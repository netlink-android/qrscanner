// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:qr_scanner/const.dart';

// import 'dataQr_page.dart';

// class ScanQrPage extends StatefulWidget {
//   const ScanQrPage({super.key});

//   @override
//   State<ScanQrPage> createState() => _ScanQrPageState();
// }

// class _ScanQrPageState extends State<ScanQrPage> {
//   // MobileScannerController controller = new MobileScannerController();
//   double zoom = 1;
//   int indexTop = 0;
//   bool codeState = false;

//   //Qr scanner
//   Barcode? result;
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   @override
//   void reassemble() {
//     super.reassemble();
//     controller!.resumeCamera();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

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
//                     onPressed: () async {
//                       await controller?.toggleFlash();
//                       setState(() {});
//                       // print(controller.torchState.value);
//                     },
//                     icon: FutureBuilder(
//                       future: controller?.getFlashStatus(),
//                       builder: (context, snapshot) {
//                         return Icon(
//                           snapshot.data == true
//                               ? Icons.flash_on
//                               : Icons.flash_off,
//                           size: 25,
//                         );
//                       },
//                     ),
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
//                           onPressed: () async {
//                             await controller?.flipCamera();
//                             setState(() {});
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
//           Expanded(flex: 4, child: _buildQrView(context)),
//           // Expanded(
//           //   flex: 4,

//           //   child: Stack(
//           //     children: [
//           //        QRScannerOverlay(
//           //         overlayColour: Colors.black,
//           //         zoom: zoom,
//           //       ),
//           //       MobileScanner(
//           //           controller: controller,
//           //           // fit: FittedSizes,
//           //           allowDuplicates: false,
//           //           onDetect: (barcode, args) {
//           //             if (barcode.rawValue == null) {
//           //               debugPrint('Failed to scan Barcode');
//           //             } else {
//           //               BarcodeType type = barcode.type;
//           //               print(type.name);
//           //               final String code = barcode.rawValue!;
//           //               Navigator.of(context).push(
//           //                 MaterialPageRoute(
//           //                   builder: (ctx) => DataQrPage(
//           //                     data: code,
//           //                   ),
//           //                 ),
//           //               );
//           //               debugPrint('Barcode found! $code');
//           //             }
//           //           }),
//           //       QRScannerOverlay(
//           //         overlayColour: Colors.black.withOpacity(1),
//           //         zoom: zoom,
//           //       ),
//           //       Padding(
//           //         padding: const EdgeInsets.all(20.0),
//           //         child: Align(
//           //             widthFactor: double.infinity,
//           //             alignment: Alignment.bottomRight,
//           //             child: Row(
//           //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //               children: [
//           //                 IconButton(
//           //                     onPressed: () {
//           //                       setState(() {
//           //                         if (zoom > 1) {
//           //                           zoom -= 0.1;
//           //                         } else if (zoom == 1) {
//           //                           zoom = zoom;
//           //                         }
//           //                       });
//           //                     },
//           //                     icon: Icon(
//           //                       Icons.strikethrough_s,
//           //                       color: Colors.white,
//           //                       size: 50,
//           //                     )),

//           //                 IconButton(
//           //                     onPressed: () {
//           //                       setState(() {
//           //                         if (zoom < 1.6) {
//           //                           zoom += 0.1;
//           //                         } else if (zoom == 1.6) {
//           //                           zoom = zoom;
//           //                         }
//           //                       });
//           //                     },
//           //                     icon: Icon(
//           //                       Icons.add,
//           //                       color: Colors.white,
//           //                       size: 50,
//           //                     )),
//           //                 // buildSliderTopLabel(),
//           //               ],
//           //             )),
//           //       )
//           //     ],
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget _buildQrView(BuildContext context) {
//     // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 250.0
//         : 400.0;
//     // To ensure the Scanner view is properly sizes after rotation
//     // we need to listen for Flutter SizeChanged notification and update controller
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 5,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: scanArea),
//       onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//         data();
//         // Navigator.of(context).push(
//         //   MaterialPageRoute(
//         //     builder: (ctx) => DataQrPage(
//         //       data: result!.code.toString(),
//         //     ),
//         //   ),
//         // );
//         print(result!.code);
//         print(result!.runtimeType);
//         print(result!.format.formatName.hashCode);
//         print(result!.format.formatName);
//         print(result!.format.name);
//         print(result!.format.runtimeType);
//         print(result!.runtimeType);
//       });
//     });
//   }

//   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//     if (!p) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('no Permission')),
//       );
//     }
//   }

//   void data() {
//     // if (codeState == true) {
//     //   Navigator.of(context).push(
//     //     MaterialPageRoute(
//     //       builder: (ctx) => DataQrPage(
//     //         data: result!.code.toString(),
//     //       ),
//     //     ),
//     //   );
//     // }
//     String data = result!.code.toString();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(data)),
//     );
//   }

//   @override
//   void dispose() {
//     // controller?.dispose();
//     super.dispose();
//     print("dispose");
//   }
// }
