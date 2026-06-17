import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

class ApplyingActivityFooter extends StatelessWidget {
  final VoidCallback? onApplyCancelButtonPressed;
  final VoidCallback? onApplyListButtonPressed;
  const ApplyingActivityFooter({
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
          ElevatedButton(
            onPressed: onApplyCancelButtonPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFFF34343),
              foregroundColor: Colors.white,
              fixedSize: Size(screenWidth * 0.401, 63),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
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
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.024),
            child: OutlinedButton(
              onPressed: onApplyListButtonPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: appPrimaryColor,
                fixedSize: Size(screenWidth * 0.401, 63),
                padding: EdgeInsets.zero,
                side: const BorderSide(color: appPrimaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
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
          ),
        ],
      ),
    );
  }
}
