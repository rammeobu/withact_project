import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

class FindWorkFilterFooter extends StatelessWidget {
  final VoidCallback onApplyFilterButtonPressed;
  const FindWorkFilterFooter({
    super.key,
    required this.onApplyFilterButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        fixedSize: Size(screenWidth, 57),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.036),
        ),
        backgroundColor: appPrimaryColor,
        foregroundColor: Colors.white,
        side: BorderSide.none,
      ),
      onPressed: onApplyFilterButtonPressed,
      child: Text(
        '적용하기',
        style: TextStyle(
          fontSize: screenWidth * 0.044,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
