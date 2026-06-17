import 'package:flutter/material.dart';

class ParticipatingPartyFooter extends StatelessWidget {
  final VoidCallback onPartyExitButtonPressed;
  const ParticipatingPartyFooter({
    super.key,
    required this.onPartyExitButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.zero,
        fixedSize: Size(screenWidth * 0.927, 57),
        backgroundColor: const Color(0xFFF34343),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
        ),
      ),
      onPressed: onPartyExitButtonPressed,
      child: Text(
        '파티 탈퇴',
        style: TextStyle(
          fontSize: screenWidth * 0.044,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
