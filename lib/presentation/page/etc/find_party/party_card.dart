import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

class PartyCard extends StatelessWidget {
  final String partyName;
  final String? poster;
  final String activityName;
  final VoidCallback? onPartyLeaderInformationCheckButtonPressed;
  final VoidCallback? onRecruitAnnouncementCheckButtonPressed;
  final VoidCallback? onApplyButtonPressed;
  const PartyCard({
    super.key,
    required this.partyName,
    this.poster,
    required this.activityName,
    required this.onPartyLeaderInformationCheckButtonPressed,
    required this.onRecruitAnnouncementCheckButtonPressed,
    required this.onApplyButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: cardColor,
        elevation: 2,
        shadowColor: Colors.black26,
        borderRadius: BorderRadius.circular(screenWidth * 0.045),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cardThumb(poster, screenWidth, screenWidth * 0.2),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            partyName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: screenWidth * 0.046,
                              fontWeight: FontWeight.w800,
                              color: cardInk,
                              height: 1.2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: cardInfoRow(
                              Icons.local_activity_outlined,
                              activityName.isEmpty ? '활동 미지정' : activityName,
                              screenWidth,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onPartyLeaderInformationCheckButtonPressed,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: appPrimaryColor,
                          side: const BorderSide(color: appPrimaryColor),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.03),
                          ),
                        ),
                        child: Text(
                          '파티장 정보',
                          style: TextStyle(
                            fontSize: screenWidth * 0.03,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: OutlinedButton(
                          onPressed: onRecruitAnnouncementCheckButtonPressed,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: appPrimaryColor,
                            side: const BorderSide(color: appPrimaryColor),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.03),
                            ),
                          ),
                          child: Text(
                            '모집 공고',
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: ElevatedButton(
                          onPressed: onApplyButtonPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appPrimaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.03),
                            ),
                          ),
                          child: Text(
                            '지원하기',
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
