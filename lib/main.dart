import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:news_app/Pages/SplashScreen.dart';
import 'package:news_app/vars/globals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initTheme();
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
        home: SplashScreen(
          toggleTheme: toogleTheme,
        ));
  }
}
