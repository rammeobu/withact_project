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
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        fixedSize: Size(screenWidth * 0.927, 57),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFFF34343),
        side: const BorderSide(width: 0.0, color: Color(0xFFF34343)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.036),
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
