import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

class RecruitAnnouncementBody2 extends StatelessWidget {
  final List<String>? preferences;
  final ScrollController scrollController;
  const RecruitAnnouncementBody2({
    super.key,
    this.preferences,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final List<String> preference = preferences ?? [];
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '우대사항',
                style: TextStyle(
                  fontSize: screenWidth * 0.058,
                  fontWeight: FontWeight.w800,
                  color: cardInk,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Material(
              color: cardColor,
              elevation: 2,
              shadowColor: Colors.black26,
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: screenWidth,
                height: 68,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: preference.isEmpty
                      ? Center(
                          child: Text(
                            '등록된 우대사항이 없습니다.',
                            style: TextStyle(
                              color: cardSub,
                              fontSize: screenWidth * 0.034,
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...preference.map(
                                (prefer) => Padding(
                                  padding: EdgeInsets.only(
                                    right: screenWidth * 0.019,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 7,
                                    ),
                                    decoration: BoxDecoration(
                                      color: cardChipBg,
                                      borderRadius: BorderRadius.circular(
                                        screenWidth * 0.05,
                                      ),
                                    ),
                                    child: Text(
                                      '#$prefer',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.034,
                                        fontWeight: FontWeight.w600,
                                        color: appPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
