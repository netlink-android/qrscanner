import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner/const.dart';
import 'package:qr_scanner/bottomNavigator/create.dart';
import 'package:qr_scanner/bottomNavigator/favorite.dart';
import 'package:qr_scanner/bottomNavigator/history.dart';
import 'package:qr_scanner/bottomNavigator/home_page.dart';
import 'package:qr_scanner/bottomNavigator/setting.dart';
import 'package:qr_scanner/them_provider.dart';

void main() async {
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
            home: MainPage(),
          );
        },
      );
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  Widget currenScreen = ScanQrPage();
  final PageStorageBucket _pageStorageBucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageStorage(
        bucket: _pageStorageBucket,
        child: SafeArea(child: currenScreen),
      ),
      floatingActionButton: FloatingActionButton(
        enableFeedback: false,
        backgroundColor: blue,
        onPressed: () {
          setState(() {
            currentIndex = 0;
            currenScreen = ScanQrPage();
          });
        },
        child: Icon(Icons.qr_code),
      ),
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
