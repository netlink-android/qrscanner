package com.example.qr_scanner

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin


class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine, "listTile", NativeAdFactorySmall(context))
          GoogleMobileAdsPlugin.registerNativeAdFactory(
              flutterEngine, "listTileMedium",NativeAdFactoryMedium(context))
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile")
          GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTileMedium")
    }
}
