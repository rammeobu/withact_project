import 'package:flutter/material.dart';

class ApplyingWorkFooter extends StatelessWidget {
  final VoidCallback? onApplyCancelButtonPressed;
  final VoidCallback? onApplyListButtonPressed;
  const ApplyingWorkFooter({
    super.key,
    this.onApplyCancelButtonPressed,
    this.onApplyListButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.039,
        top: 12,
        right: screenWidth * 0.039,
        bottom: 23,
      ),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: onApplyCancelButtonPressed,
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFFF34343),
              fixedSize: Size(screenWidth * 0.401, 63),
              padding: EdgeInsets.zero,
              side: const BorderSide(width: 0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.073),
              ),
            ),
            child: Text(
              '지원 취소',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.049,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.024),
          OutlinedButton(
            onPressed: onApplyListButtonPressed,
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              fixedSize: Size(screenWidth * 0.401, 63),
              padding: EdgeInsets.zero,
              side: const BorderSide(width: 0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.073),
              ),
            ),
            child: Text(
              '지원 목록',
              style: TextStyle(
                fontSize: screenWidth * 0.049,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
