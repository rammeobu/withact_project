import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

class ApplyPartyCard extends StatelessWidget {
  final String? poster;
  final String name;
  final List<String> timePlace;
  final String applyStatus;
  final VoidCallback onDetailButtonPressed;
  final VoidCallback onCheckProfileButtonPressed;
  const ApplyPartyCard({
    super.key,
    this.poster,
    required this.name,
    required this.timePlace,
    required this.applyStatus,
    required this.onDetailButtonPressed,
    required this.onCheckProfileButtonPressed,
  });

  Color get _statusColor {
    if (applyStatus.contains('합격') && !applyStatus.contains('불')) {
      return const Color(0xFF1AB97A);
    }
    if (applyStatus.contains('불합격')) return const Color(0xFFF34343);
    return cardSub;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final String date = timePlace.isNotEmpty ? timePlace[0] : '';
    final String place = timePlace.length > 1 ? timePlace[1] : '';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: 6),
      child: Material(
        color: cardColor,
        elevation: 2,
        shadowColor: Colors.black26,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 410,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cardPoster(poster, screenWidth, 168),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.045,
                    14,
                    screenWidth * 0.045,
                    10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.048,
                                    fontWeight: FontWeight.w800,
                                    color: cardInk,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _statusColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  applyStatus,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: cardInfoRow(
                              Icons.event_outlined,
                              date.isEmpty ? '기간 미정' : date,
                              screenWidth,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: cardInfoRow(
                              Icons.place_outlined,
                              place.isEmpty ? '장소 미정' : place,
                              screenWidth,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: onDetailButtonPressed,
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
                                '활동 설명',
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
                                onPressed: onCheckProfileButtonPressed,
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
                                  '지원서 확인',
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
