import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

class RecruitAnnouncementBody extends StatelessWidget {
  final VoidCallback? onSearchButtonPressed;
  final ScrollController scrollController;
  final String content;
  final String section;

  const RecruitAnnouncementBody({
    super.key,
    this.onSearchButtonPressed,
    required this.scrollController,
    required this.content,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool empty = content.trim().isEmpty;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section,
            style: TextStyle(
              fontSize: screenWidth * 0.058,
              fontWeight: FontWeight.w800,
              color: cardInk,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Material(
              color: cardColor,
              elevation: 2,
              shadowColor: Colors.black26,
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              clipBehavior: Clip.antiAlias,
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: section == '활동 이름' ? 48 : 64,
                ),
                padding: EdgeInsets.all(screenWidth * 0.04),
                alignment: Alignment.centerLeft,
                child: Text(
                  empty ? '등록된 내용이 없습니다.' : content,
                  style: TextStyle(
                    fontSize: screenWidth * 0.041,
                    height: 1.4,
                    color: empty ? cardSub : cardInk,
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
