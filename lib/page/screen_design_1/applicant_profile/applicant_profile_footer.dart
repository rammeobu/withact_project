import 'package:flutter/material.dart';

class ApplicantProfileFooter extends StatelessWidget {
  final VoidCallback? onTextButtonPressed;
  final VoidCallback? onAcceptButtonPressed;
  final VoidCallback? onRejectButtonPressed;
  const ApplicantProfileFooter({
    super.key,
    this.onTextButtonPressed,
    this.onAcceptButtonPressed,
    this.onRejectButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        top: screenHeight * 0.008,
        right: 16.0,
        bottom: screenHeight * 0.009,
      ),
      child: Column(
        children: [
          Row(
            children: [
              OutlinedButton(
                onPressed: onAcceptButtonPressed,
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFF1AB97A),
                  fixedSize: Size(160, screenHeight * 0.07),
                  padding: EdgeInsets.zero,
                  side: const BorderSide(width: 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  '수락',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              OutlinedButton(
                onPressed: onRejectButtonPressed,
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFF34343),
                  fixedSize: Size(160, screenHeight * 0.07),
                  padding: EdgeInsets.zero,
                  side: const BorderSide(width: 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  '거절',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.013),
          TextButton(
            onPressed: onTextButtonPressed,
            child: const Text(
              '지원자 목록으로 돌아가기',
              style: TextStyle(
                color: Color(0xFF5764F0),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
