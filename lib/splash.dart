import 'package:flutter/material.dart';
import 'package:bestbybuddy/loginpage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  // Add a duration variable for controlling the splash screen display time
  Duration _splashDuration = Duration(seconds: 3);

  // Add an animation controller for creating a smoother fade transition
  AnimationController? _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: _splashDuration,
    );
    _fadeController!.forward().then((_) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginApp()),));
  }

  @override
  void dispose() {
    _fadeController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeController!,
      child: Container(
        color: Colors.black, // Or your preferred background color
        child: Center(
          child: Image.asset(
            'images/logo.png', // Ensure your logo path is correct
            width: 200.0,
            height: 200.0,
          ),
        ),
      ),
    );
  }
}