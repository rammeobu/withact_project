import 'package:flutter/material.dart';

class AnnouncementEditFooter extends StatelessWidget {
  final VoidCallback onSaveAndExitButtonPressed;
  const AnnouncementEditFooter({
    super.key,
    required this.onSaveAndExitButtonPressed,
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
          backgroundColor: const Color(0xFFF34343),
          foregroundColor: Colors.white,
        ),
        onPressed: onSaveAndExitButtonPressed,
        child: const Text(
          '저장하고 나가기',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
