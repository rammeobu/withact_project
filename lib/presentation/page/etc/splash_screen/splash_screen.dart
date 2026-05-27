import 'package:flutter/material.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';

class SplashScreen extends StatefulWidget {
  final String? logo;
  const SplashScreen({super.key, this.logo});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          PageRoutes.login,
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: screenWidth * 0.219,
              height: screenWidth * 0.219,
              decoration: BoxDecoration(border: BoxBorder.all(width: 1.0)),
              child: Center(
                child: Text(
                  '로고',
                  style: TextStyle(fontSize: screenWidth * 0.044),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenWidth * 0.073),
              child: const CircularProgressIndicator(color: appPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
