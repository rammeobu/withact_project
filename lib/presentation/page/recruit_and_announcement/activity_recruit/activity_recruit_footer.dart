import 'package:flutter/material.dart';

class ActivityRecruitFooter extends StatelessWidget {
  final VoidCallback onRecruitStartButtonPressed;
  const ActivityRecruitFooter({
    super.key,
    required this.onRecruitStartButtonPressed,
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
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 0.0),
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          fixedSize: Size(screenWidth, 57),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(screenWidth * 0.036),
          ),
          backgroundColor: const Color(0xFF1AB97A),
          foregroundColor: Colors.white,
        ),
        onPressed: onRecruitStartButtonPressed,
        child: Text(
          '모집 시작하기',
          style: TextStyle(
            fontSize: screenWidth * 0.044,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
