import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

class ActivityCardFind extends StatelessWidget {
  final String activityName;
  final String? poster;
  final List<String> timePlace;
  final VoidCallback? onActivityInformationButtonPressed;
  final VoidCallback? onFindPartyButtonPressed;
  final bool selectMode;
  final VoidCallback? onActivitySelected;
  const ActivityCardFind({
    super.key,
    required this.activityName,
    this.poster,
    required this.timePlace,
    required this.onActivityInformationButtonPressed,
    required this.onFindPartyButtonPressed,
    this.selectMode = false,
    this.onActivitySelected,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final String date = timePlace.isNotEmpty ? timePlace[0] : '';
    final String place = timePlace.length > 1 ? timePlace[1] : '';
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
                            activityName,
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
                              Icons.event_outlined,
                              date.isEmpty ? '기간 미정' : date,
                              screenWidth,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: cardInfoRow(
                              Icons.place_outlined,
                              place.isEmpty ? '장소 미정' : place,
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
                child: selectMode
                    ? Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: onActivitySelected,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appPrimaryColor,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    screenWidth * 0.03,
                                  ),
                                ),
                              ),
                              child: Text(
                                '이 활동으로 작성하기',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.036,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: onActivityInformationButtonPressed,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: appPrimaryColor,
                                side: const BorderSide(color: appPrimaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    screenWidth * 0.03,
                                  ),
                                ),
                              ),
                              child: Text(
                                '활동 정보',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.034,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: ElevatedButton(
                                onPressed: onFindPartyButtonPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: appPrimaryColor,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      screenWidth * 0.03,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  '파티 찾아보기',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.034,
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
