import 'package:flutter/material.dart';

class WorkRecruitFooter extends StatelessWidget {
  final VoidCallback onRecruitStartButtonPressed;
  const WorkRecruitFooter({
    super.key,
    required this.onRecruitStartButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 10.0,
        right: 16.0,
        bottom: 20.0,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 0.0),
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          fixedSize: Size(MediaQuery.of(context).size.width, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(15.0),
          ),
          backgroundColor: const Color(0xFF1AB97A),
          foregroundColor: Colors.white,
        ),
        onPressed: onRecruitStartButtonPressed,
        child: const Text(
          '모집 시작하기',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
