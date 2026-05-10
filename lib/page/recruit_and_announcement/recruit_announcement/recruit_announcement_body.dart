import 'package:flutter/material.dart';
import '../../future&component/layout/default_container.dart';

class RecruitAnnouncementBody extends StatefulWidget {
  final VoidCallback? onSearchButtonPressed;
  final String content;
  final String section;

  const RecruitAnnouncementBody({
    super.key,
    this.onSearchButtonPressed,
    required this.content,
    required this.section,
  });

  @override
  State<RecruitAnnouncementBody> createState() =>
      _RecruitAnnouncementBodyState();
}

class _RecruitAnnouncementBodyState extends State<RecruitAnnouncementBody> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0.0);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.section,
            style: const TextStyle(fontSize: 23.0, fontWeight: FontWeight.w800),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.008),
            child: DefaultContainer(
              color: const Color(0xffebedf0),
              width: MediaQuery.of(context).size.width,
              height: (widget.section == '활동 이름')
                  ? screenHeight * 0.07
                  : screenHeight * 0.22,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.content,
                  style: const TextStyle(fontSize: 17.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
