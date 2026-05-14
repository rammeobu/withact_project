import 'package:flutter/material.dart';

class FindWorkFilterFooter extends StatelessWidget {
  final VoidCallback onApplyFilterButtonPressed;
  const FindWorkFilterFooter({super.key, required this.onApplyFilterButtonPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        fixedSize: Size(MediaQuery.of(context).size.width, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: const Color(0xff5764f0),
        foregroundColor: Colors.white,
        side: BorderSide.none,
      ),
      onPressed: onApplyFilterButtonPressed,
      child: const Text(
        '적용하기',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
      ),
    );
  }
}
