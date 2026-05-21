import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

class ApplyPartyCardButton extends StatelessWidget {
  final String applyStatus;
  final VoidCallback onDetailButtonPressed;
  final VoidCallback onCheckProfileButtonPressed;
  const ApplyPartyCardButton({
    super.key,
    required this.applyStatus,
    required this.onDetailButtonPressed,
    required this.onCheckProfileButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: screenWidth,
            height: double.infinity,
            decoration: BoxDecoration(
              border: BoxBorder.fromLTRB(
                top: const BorderSide(width: 1.0, color: Colors.grey),
              ),
            ),
            child: TextButton(
              onPressed: onDetailButtonPressed,
              style: TextButton.styleFrom(foregroundColor: appPrimaryColor),
              child: Text(
                '활동 설명',
                style: TextStyle(
                  fontSize: screenWidth * 0.036,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            width: screenWidth,
            height: double.infinity,
            decoration: BoxDecoration(
              border: BoxBorder.fromLTRB(
                top: const BorderSide(width: 1.0),
                left: const BorderSide(width: 1.0, color: Colors.grey),
                bottom: BorderSide.none,
                right: BorderSide.none,
              ),
            ),
            child: TextButton(
              onPressed: onCheckProfileButtonPressed,
              style: TextButton.styleFrom(foregroundColor: appPrimaryColor),
              child: Text(
                '지원서 확인',
                style: TextStyle(
                  fontSize: screenWidth * 0.036,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
