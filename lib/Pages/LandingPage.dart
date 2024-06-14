import 'package:flutter/material.dart';
import 'package:news_app/Pages/home.dart';
import 'package:news_app/Widgets/FormWidgets.dart';
import 'package:news_app/vars/globals.dart';

class LandingPage extends StatefulWidget {
  final Function toogleTheme;
  const LandingPage({super.key, required this.toogleTheme});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                "Assets/Images/landing.jpg",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "News from around the world for You",
            style: style.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Best time to read,take your time to read a little more of this world",
            style: style.copyWith(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          customButton(
            text: "Get Started",
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          toggleTheme: widget.toogleTheme,
                        )),
                (context) => false),
            width: MediaQuery.of(context).size.width * 0.8,
          )
        ],
      ),
    );
  }
}
