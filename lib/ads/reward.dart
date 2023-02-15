import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

///22486823495/sudoku_reward
class RewardedAdManager {
  RewardedAd? rewardedAd;
  BuildContext? ct;
  Widget? wd;
  String idReward = '/22486823495/sudoku_reward';

  InterstitialAdManager(String idRw) {
    this.idReward = idRw;
  }

  void loadReward() {
    RewardedAd.load(
        adUnitId: idReward,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');

            rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');

            loadReward();
          },
        ));
  }

  void showReward(BuildContext context, Widget widget) {
    if (rewardedAd == null) {
      loadReward();
      return;
    }

    // Keep a reference to the ad so you can show it later.

    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        loadReward();
        Navigator.push(ct!, MaterialPageRoute(builder: (ct) {
          // do something
          return wd!;
        }));
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();

        loadReward();
      },
      onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
    );
    rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView adView, RewardItem rewardItem) {
      this.ct = context;
      this.wd = widget;
    });
  }
}
