import 'package:flutter/material.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';

class ApplyFail extends StatelessWidget {
  const ApplyFail({super.key});

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
                      Icons.close,
                      size: screenWidth * 0.487,
                      color: Colors.red,
                    ),
                    Text(
                      '지원 실패',
                      style: TextStyle(
                        fontSize: screenWidth * 0.085,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 23),
                      child: Text(
                        '지원 중 오류가 발생했습니다.\n 잠시 후 다시 시도해 주세요.',
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
                  onPressed: () => onRetryButtonPressed(context),
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
                    '다시 시도하기',
                    style: TextStyle(fontSize: screenWidth * 0.049),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14, bottom: 23),
                  child: OutlinedButton(
                    onPressed: () => onApplyListButtonPressed(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: appPrimaryColor,
                      side: const BorderSide(color: appPrimaryColor),
                      minimumSize: Size(screenWidth * 0.487, 57),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                    ),
                    child: Text(
                      '지원 목록으로',
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

  void onRetryButtonPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void onApplyListButtonPressed(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      PageRoutes.applyList,
      (route) => false,
    );
  }
}
