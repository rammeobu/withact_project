import 'package:flutter/material.dart';

class ParticipatingPartyFooter extends StatelessWidget {
  final VoidCallback onPartyExitButtonPressed;
  const ParticipatingPartyFooter({
    super.key,
    required this.onPartyExitButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        fixedSize: Size(MediaQuery.of(context).size.width - 30, 50),
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFFF34343),
        side: const BorderSide(width: 0.0, color: Color(0xFFF34343)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: onPartyExitButtonPressed,
      child: const Text(
        '파티 탈퇴',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
      ),
    );
  }
}
