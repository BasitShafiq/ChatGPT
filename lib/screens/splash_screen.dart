import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../main.dart';
import 'dart:async';
import './chat_screen.dart';
import '../services/assets_manager.dart';
import '../constants/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, ChatScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatGPT',
      home: Scaffold(
        backgroundColor: ScaffoldBackgroundColor,
          body: Column(
            
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 600,
            child: Image.asset(
              AssetsManger.openaiLogo,
              height: 200,
              width: 200,
            ),
          ),
          SizedBox(
            height: 60,),
          SizedBox(
            width: 60,
            child: SpinKitSpinningLines(
              color: Colors.white,
              size: 50.0,
            ),
          ),
        ],
      )),
    );
  }
}
