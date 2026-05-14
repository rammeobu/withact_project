import 'package:flutter/material.dart';

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
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        top: screenHeight * 0.008,
        right: 16.0,
        bottom: screenHeight * 0.009,
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
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  fixedSize: Size(170, screenHeight * 0.07),
                  padding: EdgeInsets.zero,
                  side: const BorderSide(width: 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  '공고 수정',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: onDisbandPartyButtonPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFF34343),
                  backgroundColor: Colors.white,
                  fixedSize: Size(170, screenHeight * 0.07),
                  padding: EdgeInsets.zero,
                  side: const BorderSide(width: 0.0, color: Color(0xFFF34343)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  '파티 해체',
                  style: TextStyle(
                    color: Color(0xFFF34343),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.013),
          OutlinedButton(
            onPressed: onRecruitButtonPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFF34343),
              backgroundColor: Colors.white,
              fixedSize: Size(340, screenHeight * 0.07),
              padding: EdgeInsets.zero,
              side: const BorderSide(width: 0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              '모집목록으로',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
