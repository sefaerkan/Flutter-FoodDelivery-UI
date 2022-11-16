import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/core/animations/animations.dart';

import '../core/utils/navigation.dart';
import 'home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _next();
    super.initState();
  }

  _next() {
    Timer(
      const Duration(milliseconds: 450),
          () {
        Navigation.push(
          context,
          customPageTransition: PageTransition(
            child: const HomeScreen(),
            type: PageTransitionType.fadeIn,
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(),
    );
  }
}
