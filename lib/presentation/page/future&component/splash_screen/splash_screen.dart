import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final String? logo;
  const SplashScreen({super.key, this.logo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(child: logo != null ? Image.asset(logo!) : Container()),
    );
  }
}
