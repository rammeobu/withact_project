import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

class RecruitCardButton extends StatelessWidget {
  final String applyStatus;
  final VoidCallback onDetailButtonPressed;
  final VoidCallback onAnnouncementManageButtonPressed;
  final VoidCallback onCheckApplicantButtonPressed;
  const RecruitCardButton({
    super.key,
    required this.applyStatus,
    required this.onDetailButtonPressed,
    required this.onAnnouncementManageButtonPressed,
    required this.onCheckApplicantButtonPressed,
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
                top: const BorderSide(width: 1.0, color: Colors.grey),
                left: const BorderSide(width: 1.0, color: Colors.grey),
              ),
            ),
            child: TextButton(
              onPressed: onAnnouncementManageButtonPressed,
              style: TextButton.styleFrom(foregroundColor: appPrimaryColor),
              child: Text(
                '공고 관리',
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
                top: const BorderSide(width: 1.0, color: Colors.grey),
                left: const BorderSide(width: 1.0, color: Colors.grey),
              ),
            ),
            child: TextButton(
              onPressed: onCheckApplicantButtonPressed,
              style: TextButton.styleFrom(foregroundColor: appPrimaryColor),
              child: Text(
                '지원자 확인',
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
