import 'package:flutter/material.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';

class Waiting extends StatelessWidget {
  const Waiting({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: appPrimaryColor),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                '잠시만 기다려 주세요.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenWidth * 0.041,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  PageRoutes.home,
                  (route) => false,
                ),
                child: Text(
                  '홈으로',
                  style: TextStyle(
                    color: appPrimaryColor,
                    fontSize: screenWidth * 0.041,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
