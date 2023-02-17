///22486823495/sudoku_native
import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdManager extends StatefulWidget {
  String idNative = '/22486823495/sudoku_native';
  bool small = true;
  NativeAdManager({Key? key, required this.idNative, required this.small})
      : super(key: key);

  @override
  State<NativeAdManager> createState() => _NativeAdManagerState();
}

class _NativeAdManagerState extends State<NativeAdManager> {
  bool isNativeAdLoaded = false;
  NativeAd? nativeAd;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    setState(() {
      loadNative();
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  void loadNative() {
    nativeAd = NativeAd(
      factoryId: widget.small ? 'listTile' : 'listTileMedium',
      adUnitId: widget.idNative,
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          print('Ad loaded.');
          setState(() {
            isNativeAdLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
          setState(() {
            isNativeAdLoaded = false;
          });
          loadNative();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {
          print('Ad opened.');
        },
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {
          print('Ad closed.');
        },
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {
          print('Ad impression.');
        },
        // Called when a click is recorded for a NativeAd.
      ),
      request: const AdRequest(),
    );
    nativeAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return isNativeAdLoaded
        ? SizedBox(
            width: double.infinity,
            height: widget.small ? 170 : 250,
            child: Container(
              child: AdWidget(
                ad: nativeAd!,
              ),
            ),
          )
        : SizedBox();
  }
}
