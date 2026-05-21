import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

class FindPartyFilterFooter extends StatelessWidget {
  final VoidCallback onApplyFilterButtonPressed;
  const FindPartyFilterFooter({
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
        '필터 적용',
        style: TextStyle(
          fontSize: screenWidth * 0.044,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
