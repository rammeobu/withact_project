import 'package:flutter/material.dart';

class RecruitFail extends StatelessWidget {
  const RecruitFail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.close, size: 200.0, color: Colors.red),
                    Text(
                      '모집 시작 실패',
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      '모집 시작 중 오류가 발생했습니다.\n 잠시 후 다시 시도해 주세요.',
                      style: TextStyle(fontSize: 20.0),
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
                  onPressed: onRetryButtonPressed,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    minimumSize: const Size(200.0, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    '다시 시도하기',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                const SizedBox(height: 12.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: OutlinedButton(
                    onPressed: onRecruitListButtonPressed,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(20.0),
                      ),
                    ),
                    child: const Text(
                      '모집 목록으로',
                      style: TextStyle(fontSize: 20.0),
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

  void onRetryButtonPressed() {}
  void onRecruitListButtonPressed() {}
}
