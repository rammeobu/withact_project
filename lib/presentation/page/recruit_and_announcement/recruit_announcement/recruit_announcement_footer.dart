import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

class RecruitAnnouncementFooter extends StatelessWidget {
  final VoidCallback? onEditAnnouncementButtonPressed;
  final VoidCallback? onDisbandPartyButtonPressed;
  final VoidCallback? onRecruitButtonPressed;
  const RecruitAnnouncementFooter({
    super.key,
    this.onEditAnnouncementButtonPressed,
    this.onDisbandPartyButtonPressed,
    this.onRecruitButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.039,
        top: 7,
        right: screenWidth * 0.039,
        bottom: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: onEditAnnouncementButtonPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: appPrimaryColor,
                  backgroundColor: Colors.white,
                  fixedSize: Size(screenWidth * 0.414, 59),
                  padding: EdgeInsets.zero,
                  side: const BorderSide(width: 1.2, color: appPrimaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.036),
                  ),
                ),
                child: Text(
                  '공고 수정',
                  style: TextStyle(
                    color: appPrimaryColor,
                    fontSize: screenWidth * 0.049,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: onDisbandPartyButtonPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFF34343),
                  backgroundColor: Colors.white,
                  fixedSize: Size(screenWidth * 0.414, 59),
                  padding: EdgeInsets.zero,
                  side: const BorderSide(width: 1.2, color: Color(0xFFF34343)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.036),
                  ),
                ),
                child: Text(
                  '파티 해체',
                  style: TextStyle(
                    color: const Color(0xFFF34343),
                    fontSize: screenWidth * 0.049,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 11),
            child: OutlinedButton(
              onPressed: onRecruitButtonPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black87,
                backgroundColor: Colors.white,
                fixedSize: Size(screenWidth * 0.828, 59),
                padding: EdgeInsets.zero,
                side: const BorderSide(width: 1.0, color: Color(0xFFD6D9DE)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.049),
                ),
              ),
              child: Text(
                '목록으로',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: screenWidth * 0.044,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
