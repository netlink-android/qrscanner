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
  int indexTop = 0;
  double valueBottom = 20;
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
                    onPressed: () {
                      setState(() {
                        controller.toggleTorch();
                      });
                      // print(controller.torchState.value);
                    },
                    icon: controller.torchState.value == TorchState.on
                        ? Icon(Icons.flash_on, size: 25)
                        : Icon(Icons.flash_off, size: 25),
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
                          onPressed: () {
                            setState(() {
                              controller.switchCamera();
                            });
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
          Expanded(
            flex: 4,
            
            child: Stack(
              children: [
                 QRScannerOverlay(
                  overlayColour: Colors.black,
                  zoom: zoom,
                ),
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
                  overlayColour: Colors.black.withOpacity(1),
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
                          // buildSliderTopLabel(),
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

  Widget buildSliderTopLabel() {
    final labels = ['-', '18', '30', '50', '+'];
    final double min = 0;
    final double max = labels.length - 1.0;
    final divisions = labels.length - 1;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: Utils.modelBuilder(
              labels,
              (index, label) {
                final selectedColor = white;
                final unselectedColor = Colors.white.withOpacity(0.3);
                final isSelected = index <= indexTop;
                final color = isSelected ? selectedColor : unselectedColor;

                return buildLabel(label: label, color: color, width: 30);
              },
            ),
          ),
        ),
        Slider(
          value: indexTop.toDouble(),
          min: min,
          max: max,
          divisions: divisions,
          activeColor: white,
          inactiveColor: red,
          // label: labels[indexTop],
          onChanged: (value) => setState(() => this.indexTop = value.toInt()),
        ),
      ],
    );
  }

  Widget buildLabel({
    required String label,
    required double width,
    required Color color,
  }) =>
      Container(
        width: width,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ).copyWith(color: color),
        ),
      );

  Widget buildSideLabel(double value) => Container(
        width: 25,
        child: Text(
          value.round().toString(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
}

class Utils {
  static List<Widget> modelBuilder<M>(
          List<M> models, Widget Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, Widget>(
              (index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();
}
