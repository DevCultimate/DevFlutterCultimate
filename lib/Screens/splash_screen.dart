import 'dart:async';
import 'package:cultimate/Authentication/login_screen.dart';
// import 'package:cultimate/Screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import Lottie package

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        // MaterialPageRoute(builder: (context) => const HomePage()),
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
         
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/CultimateLogoAnimated.gif',
                fit: BoxFit.cover, // Adjust size as needed
              ),
              SizedBox(height: 20),
              Lottie.asset(
                'assets/splashanimation.json',
                width: 250,
                height: 250,
                frameRate: FrameRate(40), // Adjust speed as needed (default is 1.0)
                // Optionally, you can specify other parameters such as controller, repeat, etc.
              ),
            ],
          ),
        ],
      ),
    );
  }
}
