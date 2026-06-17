import 'package:flutter/material.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';

class SplashScreen extends StatefulWidget {
  final String? logo;
  const SplashScreen({super.key, this.logo});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            PageRoutes.login,
            (route) => false,
          );
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/images/app_logo.png'), context);
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
            Image.asset(
              'assets/images/app_logo.png',
              width: screenWidth * 0.219,
              height: screenWidth * 0.219,
              fit: BoxFit.contain,
              cacheWidth: 400,
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
