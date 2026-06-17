import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

import '../../future&component/component/person.dart';

class RecruitAnnouncementBody3 extends StatelessWidget {
  final List<String> position;
  final ScrollController primaryScrollController;
  final ScrollController horizontalScrollController;
  const RecruitAnnouncementBody3({
    super.key,
    required this.position,
    required this.primaryScrollController,
    required this.horizontalScrollController,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '모집역할/인원',
          style: TextStyle(
            fontSize: screenWidth * 0.058,
            fontWeight: FontWeight.w800,
            color: cardInk,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 9),
          child: SingleChildScrollView(
            controller: horizontalScrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: position.map((pos) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.012,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: cardChipBg,
                            borderRadius: BorderRadius.circular(
                              screenWidth * 0.05,
                            ),
                          ),
                          child: Text(
                            pos,
                            style: TextStyle(
                              fontSize: screenWidth * 0.036,
                              fontWeight: FontWeight.w600,
                              color: appPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                      Person(size: screenWidth * 0.122),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
