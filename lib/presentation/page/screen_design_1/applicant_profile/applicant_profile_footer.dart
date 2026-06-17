import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

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
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.039,
        top: 7,
        right: screenWidth * 0.039,
        bottom: 8,
      ),
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: onAcceptButtonPressed,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF1AB97A),
                  foregroundColor: Colors.white,
                  fixedSize: Size(screenWidth * 0.389, 59),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  ),
                ),
                child: Text(
                  '수락',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.049,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.024),
                child: ElevatedButton(
                  onPressed: onRejectButtonPressed,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFFF34343),
                    foregroundColor: Colors.white,
                    fixedSize: Size(screenWidth * 0.389, 59),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                  ),
                  child: Text(
                    '거절',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.049,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 11),
            child: TextButton(
              onPressed: onTextButtonPressed,
              child: Text(
                '지원자 목록으로 돌아가기',
                style: TextStyle(
                  color: appPrimaryColor,
                  fontSize: screenWidth * 0.044,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
