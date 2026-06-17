import 'package:flutter/material.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';

class PartyExitSuccess extends StatelessWidget {
  const PartyExitSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.061),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: screenWidth * 0.487,
                      color: Colors.green,
                    ),
                    Text(
                      '탈퇴 성공',
                      style: TextStyle(
                        fontSize: screenWidth * 0.085,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 23),
                      child: Text(
                          '정상적으로\n 파티를 탈퇴하였습니다!',
                        style: TextStyle(fontSize: screenWidth * 0.049),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 14, bottom: 23),
                  child: ElevatedButton(
                    onPressed: () => onHomeScreenButtonPressed(context),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: appPrimaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: Size(screenWidth * 0.487, 57),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          screenWidth * 0.049,
                        ),
                      ),
                    ),
                    child: Text(
                      '대기 화면으로',
                      style: TextStyle(
                        fontSize: screenWidth * 0.049,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onHomeScreenButtonPressed(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      PageRoutes.home,
      (route) => false,
    );
  }
}
