import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/ads/interstitial.dart';
import 'package:qr_scanner/bottomNavigator/qrscanner.dart';
import 'package:qr_scanner/const.dart';
import 'package:qr_scanner/bottomNavigator/create.dart';
import 'package:qr_scanner/bottomNavigator/favorite.dart';
import 'package:qr_scanner/bottomNavigator/history.dart';
import 'package:qr_scanner/bottomNavigator/home_page.dart';
import 'package:qr_scanner/bottomNavigator/setting.dart';
import 'package:qr_scanner/them_provider.dart';

import 'ads/openapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home: Splash(),
          );
        },
      );
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  InterstitialAdManager? interstitialAdManager;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    interstitialAdManager =
        InterstitialAdManager('/22486823495/sudoku_iterstitial')
          ..loadInterstitial();
    setState(() {
      _splash();
    });
  }

  _splash() async {
    await Future.delayed(Duration(milliseconds: 10000), () {
      setState(() {
        interstitialAdManager!.showInterstitial(context, MainPage());
      });
    });
    // setState(() {
    //   Navigator.push(context, MaterialPageRoute(builder: (ct) {
    //     // do something
    //     return MainPage();
    //   }));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 100,
                width: 100,
                child: Image.asset('assets/iconcustom/logoQr.png')),
          ),
          Text(
            'Qr Scanner',
            style: textType,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              color: blue,
            ),
          ),
           Text(
            'Showing ads...',
            style: textType.copyWith(fontWeight: FontWeight.normal, fontSize: 18),
          ),
        ],
      )),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AppOpenAdManager? appOpenAdManager;
  int currentIndex = 0;
  Widget currenScreen = QrScannerPage();
  final PageStorageBucket _pageStorageBucket = PageStorageBucket();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   appOpenAdManager = AppOpenAdManager()..loadAd();
  //   WidgetsBinding.instance
  //       .addObserver(AppLifecycleReactor(appOpenAdManager: appOpenAdManager!));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageStorage(
        bucket: _pageStorageBucket,
        child: SafeArea(child: currenScreen),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: "btnScan",
          enableFeedback: false,
          backgroundColor: blue,
          onPressed: () {
            setState(() {
              currentIndex = 0;
              currenScreen = QrScannerPage();
            });
          },
          child: CircleAvatar(
            child: Container(
                height: 100,
                width: 100,
                child: Image.asset('assets/iconcustom/logoQr.png')),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = 1;
                        currenScreen = HistoryPage();
                      });
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          color: currentIndex == 1 ? blue : grey,
                        ),
                        Text(
                          'History',
                          style: TextStyle(
                            color: currentIndex == 1 ? blue : grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = 2;
                        currenScreen = CreatePage();
                      });
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dashboard_customize_outlined,
                          color: currentIndex == 2 ? blue : grey,
                        ),
                        Text(
                          'Create',
                          style: TextStyle(
                            color: currentIndex == 2 ? blue : grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = 3;
                        currenScreen = FavoritePage();
                      });
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: currentIndex == 3 ? blue : grey,
                        ),
                        Text(
                          'Favorite',
                          style: TextStyle(
                            color: currentIndex == 3 ? blue : grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = 4;
                        currenScreen = SettingPage();
                      });
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: currentIndex == 4 ? blue : grey,
                        ),
                        Text(
                          'Setting',
                          style: TextStyle(
                            color: currentIndex == 4 ? blue : grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
