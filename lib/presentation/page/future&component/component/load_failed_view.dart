import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

class LoadFailedView extends StatelessWidget {
  final VoidCallback onRetry;
  const LoadFailedView({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '불러오지 못했습니다.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: screenWidth * 0.041,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: OutlinedButton(
                onPressed: onRetry,
                style: OutlinedButton.styleFrom(
                  foregroundColor: appPrimaryColor,
                  side: const BorderSide(color: appPrimaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.036),
                  ),
                ),
                child: Text(
                  '다시 시도',
                  style: TextStyle(
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
