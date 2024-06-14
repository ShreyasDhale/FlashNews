import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/Pages/LandingPage.dart';
import 'package:news_app/vars/globals.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class SplashScreen extends StatefulWidget {
  final Function toggleTheme;
  const SplashScreen({super.key, required this.toggleTheme});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);

    controller.forward();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LandingPage(
                    toogleTheme: widget.toggleTheme,
                  )));
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.currentTheme.brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScaleTransition(
              scale: animation,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('Assets/Images/logo.png',
                    width: 150, height: 150),
              ),
            ),
            const SizedBox(height: 20),
            TextAnimator(
              "Flash News",
              incomingEffect: WidgetTransitionEffects(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 500)),
              style: style.copyWith(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontFamily: 'Agne'),
            ),
            const SizedBox(height: 20),
            const SpinKitFadingCircle(
              color: Colors.red,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
