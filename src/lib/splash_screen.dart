import 'package:flutter/material.dart';
import 'dart:async';

import 'bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2), // Duration of fade effect
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(Duration(seconds: 1), () { // delay after animation completes
            _animationController.reverse();
          });
        } else if (status == AnimationStatus.dismissed) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBarApp()),
          );
        }
      });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFc4ff61),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset('lib/splash.png'),
        ),
      ),
    );
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
