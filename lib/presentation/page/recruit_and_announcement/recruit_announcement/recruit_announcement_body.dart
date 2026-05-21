import 'package:flutter/material.dart';
import '../../future&component/layout/default_container.dart';

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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: DefaultContainer(
              color: const Color(0xffebedf0),
              width: screenWidth,
              height: (section == '활동 이름') ? 59 : 186,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.019),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Text(
                    content,
                    style: TextStyle(fontSize: screenWidth * 0.041),
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
