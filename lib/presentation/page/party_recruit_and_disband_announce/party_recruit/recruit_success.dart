import 'package:flutter/material.dart';
import 'package:party_maker/app.dart';

class RecruitSuccess extends StatelessWidget {
  const RecruitSuccess({super.key});

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
                      '모집 준비 완료',
                      style: TextStyle(
                        fontSize: screenWidth * 0.085,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 23),
                    Text(
                      '정상적으로\n 모집이 시작되었습니다!',
                      style: TextStyle(fontSize: screenWidth * 0.049),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlinedButton(
                  onPressed: () => onRecruitListButtonPressed(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    minimumSize: Size(screenWidth * 0.487, 57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(
                        screenWidth * 0.049,
                      ),
                    ),
                  ),
                  child: Text(
                    '모집 목록으로',
                    style: TextStyle(fontSize: screenWidth * 0.049),
                  ),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.only(bottom: 23),
                  child: OutlinedButton(
                    onPressed: () => onHomeScreenButtonPressed(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      minimumSize: Size(screenWidth * 0.487, 57),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(
                          screenWidth * 0.049,
                        ),
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
