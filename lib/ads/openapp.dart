import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppLifecycleReactor extends WidgetsBindingObserver {
  final AppOpenAdManager appOpenAdManager;

  AppLifecycleReactor({required this.appOpenAdManager});

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    if (state == AppLifecycleState.resumed) {
      appOpenAdManager.showAd();
    }
  }
}

class AppOpenAdManager {
  AppOpenAd? openAd;

  Future<void> loadAd() async {
    await AppOpenAd.load(
        adUnitId: '/22486823495/sudoku_open',
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad) {
          print('ad is loaded');
          openAd = ad;
          // openAd!.show();
        }, onAdFailedToLoad: (error) {
          print('ad failed to load $error');
        }),
        orientation: AppOpenAd.orientationPortrait);
  }

  void showAd() {
    if (openAd == null) {
      print('trying tto show before loading');
      loadAd();
      return;
    }

    openAd!.fullScreenContentCallback =
        FullScreenContentCallback(onAdShowedFullScreenContent: (ad) {
      print('onAdShowedFullScreenContent');
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      ad.dispose();
      print('failed to load $error');
      openAd = null;
      loadAd();
    }, onAdDismissedFullScreenContent: (ad) {
      ad.dispose();
      print('dismissed');
      openAd = null;
      loadAd();
    });

    openAd!.show();
  }
}
