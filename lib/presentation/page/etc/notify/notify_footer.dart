import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

class NotifyFooter extends StatelessWidget {
  final VoidCallback onReadAndDeleteButtonPressed;
  const NotifyFooter({super.key, required this.onReadAndDeleteButtonPressed});

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
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          fixedSize: Size(screenWidth, 57),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          backgroundColor: appPrimaryColor,
          foregroundColor: Colors.white,
        ),
        onPressed: onReadAndDeleteButtonPressed,
        child: Text(
          '읽음으로 처리',
          style: TextStyle(
            fontSize: screenWidth * 0.044,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
