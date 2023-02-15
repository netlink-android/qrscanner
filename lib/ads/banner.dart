import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class CustomBannerAd extends StatefulWidget {
  String idBanner = '/22486823495/sudoku_banner';
  CustomBannerAd({Key? key, required this.idBanner}) : super(key: key);

  @override
  State<CustomBannerAd> createState() => _CustomBannerAdState();
}

class _CustomBannerAdState extends State<CustomBannerAd> {
  bool isBannerAdLoaded = false;
  BannerAd? bannerAd;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    setState(() {
      loadBanner();
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  void loadBanner() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: widget.idBanner,
      listener: BannerAdListener(onAdFailedToLoad: (ad, error) {
        loadBanner();
        print("Ad Failed to Load");
        ad.dispose();
      }, onAdLoaded: (ad) {
        print("Ad Loaded");
        setState(() {
          isBannerAdLoaded = true;
        });
      }),
      request: const AdRequest(),
    );
    bannerAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return isBannerAdLoaded
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: AdWidget(
              ad: bannerAd!,
            ),
          )
        : SizedBox();
  }
}
