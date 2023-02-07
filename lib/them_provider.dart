import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_scanner/const.dart';

class ThemeProvider extends ChangeNotifier {
  bool theme = false;
  final switchData = GetStorage();

  bool statte = true;
  ThemeMode get themeMode {
    // if (themeMode == ThemeMode.system) {
    //   final brightness = SchedulerBinding.instance.window.platformBrightness;
    //   return brightness == Brightness.dark;
    // } else {
    //   return themeMode == ThemeMode.dark;
    // }
    if (switchData.read('isSwitched') != null) {
      theme = switchData.read('isSwitched');
      if (theme) {
        return ThemeMode.dark;
      } else {
        return ThemeMode.light;
      }
    } else {
      return ThemeMode.light;
    }
  }

  void toggleTheme(bool isOn) {
    // if (switchData.read('isSwitched') != null) {
    //   isOn = switchData.read('isSwitched');
    // }
    theme = isOn;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme:
        ColorScheme.dark(surface: Colors.lightBlue, onSecondary: white, primaryVariant:  white,  ),
    primarySwatch: Colors.lightBlue,
    iconTheme: IconThemeData(color: white, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme:
        ColorScheme.light(primary: Colors.lightBlue, onSecondary: white, secondaryVariant:  black),
    primarySwatch: Colors.lightBlue,
    iconTheme: IconThemeData(color: black, opacity: 0.8),
  );
}
