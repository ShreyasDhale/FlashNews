import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:news_app/Pages/Offline.dart';
import 'package:news_app/Pages/SplashScreen.dart';
import 'package:news_app/vars/globals.dart';

enum ScreenType { login, offline }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Connectivity _connectivity;
  late ConnectivityResult _connectionStatus;
  ScreenType _currentScreenType = ScreenType.login;

  @override
  void initState() {
    super.initState();
    initTheme();
    _connectivity = Connectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _updateConnectionStatus(ConnectivityResult.none);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      if (_connectionStatus == ConnectivityResult.none) {
        _currentScreenType = ScreenType.offline;
      } else {
        _currentScreenType = ScreenType.login;
      }
    });
  }

  void initTheme() {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    setState(() {
      if (isDarkMode) {
        AppTheme.currentTheme = ThemeData.dark();
      } else {
        AppTheme.currentTheme = ThemeData.light();
      }
    });
  }

  void toogleTheme() {
    setState(() {
      if (AppTheme.currentTheme == ThemeData.dark()) {
        AppTheme.currentTheme = ThemeData.light();
      } else {
        AppTheme.currentTheme = ThemeData.dark();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flash News',
        theme: AppTheme.currentTheme,
        debugShowCheckedModeBanner: false,
        home: (_currentScreenType == ScreenType.login)
            ? SplashScreen(
                toggleTheme: toogleTheme,
              )
            : const OfflinePage());
  }
}
