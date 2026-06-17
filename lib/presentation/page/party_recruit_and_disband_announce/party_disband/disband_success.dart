import 'package:flutter/material.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';

class DisbandSuccess extends StatelessWidget {
  const DisbandSuccess({super.key});

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
                      '파티 해체 완료',
                      style: TextStyle(
                        fontSize: screenWidth * 0.085,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 23),
                      child: Text(
                          '정상적으로\n 파티를 해체하였습니다!',
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
                ElevatedButton(
                  onPressed: () => onRecruitListButtonPressed(context),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: appPrimaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: Size(screenWidth * 0.487, 57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                  ),
                  child: Text(
                    '모집 목록으로',
                    style: TextStyle(
                      fontSize: screenWidth * 0.049,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14, bottom: 23),
                  child: OutlinedButton(
                    onPressed: () => onHomeScreenButtonPressed(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: appPrimaryColor,
                      side: const BorderSide(
                        width: 1.2,
                        color: appPrimaryColor,
                      ),
                      minimumSize: Size(screenWidth * 0.487, 57),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                    ),
                    child: Text(
                      '대기 화면으로',
                      style: TextStyle(fontSize: screenWidth * 0.049),
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

  void onRecruitListButtonPressed(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      PageRoutes.recruitList,
      (route) => false,
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
