import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

class ApplyFooter extends StatelessWidget {
  final VoidCallback onApplyButtonPressed;
  const ApplyFooter({super.key, required this.onApplyButtonPressed});

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
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 0.0),
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          fixedSize: Size(screenWidth, 57),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(screenWidth * 0.036),
          ),
          backgroundColor: appPrimaryColor,
          foregroundColor: Colors.white,
        ),
        onPressed: onApplyButtonPressed,
        child: Text(
          '지원하기',
          style: TextStyle(
            fontSize: screenWidth * 0.044,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
