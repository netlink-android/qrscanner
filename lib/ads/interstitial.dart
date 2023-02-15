///22486823495/sudoku_iterstitial
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

///22486823495/sudoku_reward
class InterstitialAdManager {
  InterstitialAd? interstitialAd;
  String idInter = '';
  InterstitialAdManager(String idInterstitial) {
    this.idInter = idInterstitial;
  }
  bool isInterstitialAdLoaded = false;
  bool isRewardAdLoaded = false;

  void loadInterstitial() {
    InterstitialAd.load(
      adUnitId: idInter,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print("Ad Loaded");
          interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          print("Ad Failed to Load");

          loadInterstitial();
        },
      ),
    );
  }

  void showInterstitial(BuildContext context, Widget widget) {
    if (interstitialAd == null) {
      loadInterstitial();
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('%ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');

        ad.dispose();

        loadInterstitial();

        Navigator.push(context, MaterialPageRoute(builder: (ct) {
          // do something
          return widget;
        }));
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();

        loadInterstitial();
      },
      onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
    );
    interstitialAd!.show();
  }
}
