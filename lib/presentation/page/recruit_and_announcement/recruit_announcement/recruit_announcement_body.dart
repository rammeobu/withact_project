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
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section,
            style: const TextStyle(fontSize: 23.0, fontWeight: FontWeight.w800),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.008),
            child: DefaultContainer(
              color: const Color(0xffebedf0),
              width: MediaQuery.of(context).size.width,
              height: (section == '활동 이름')
                  ? screenHeight * 0.07
                  : screenHeight * 0.22,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Text(content, style: const TextStyle(fontSize: 17.0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
