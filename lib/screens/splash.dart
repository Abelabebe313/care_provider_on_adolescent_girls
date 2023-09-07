import 'package:care_provider_on_adolescent_girls_mobile/screens/home.dart';
import 'package:care_provider_on_adolescent_girls_mobile/screens/onboarding.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Container(
        decoration: const BoxDecoration(color: Colors.white70),
        child: Center(
          child: Container(
            width: 250,
            height: 100,
            margin: const EdgeInsets.only(bottom: 50),
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
