import 'package:flutter/material.dart';
import 'package:party_maker/page/recruit_and_announcement/recruit_announcement/recruit_announcement_body2.dart';
import 'package:party_maker/page/recruit_and_announcement/recruit_announcement/recruit_announcement_body3.dart';
import '../../future&component/layout/basic_layout.dart';
import 'recruit_announcement_body.dart';
import 'recruit_announcement_footer.dart';

class RecruitAnnouncement extends StatefulWidget {
  final List<String>? preferences;
  final String? poster;
  final List<String> position;
  final List<String> content;
  const RecruitAnnouncement({
    super.key,
    this.preferences,
    this.poster,
    required this.content,
    required this.position,
  });

  @override
  State<RecruitAnnouncement> createState() => _RecruitAnnouncementState();
}

class _RecruitAnnouncementState extends State<RecruitAnnouncement> {
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
    return BasicLayout(
      title: '모집 공고',
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RecruitAnnouncementBody(
                      section: '활동 이름',
                      content: widget.content[0] ?? '',
                      onSearchButtonPressed: onSearchButtonPressed,
                    ),
                    RecruitAnnouncementBody(
                      section: '파티 이름/소개',
                      content: widget.content.length < 2
                          ? ''
                          : widget.content[1],
                    ),
                    RecruitAnnouncementBody2(preferences: widget.preferences),
                    const SizedBox(height: 20.0),
                    RecruitAnnouncementBody3(
                      position: widget.position,
                      primaryScrollController: _scrollController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: screenHeight * 0.007,
            ),
            child: RecruitAnnouncementFooter(
              onEditAnnouncementButtonPressed: onEditAnnouncementButtonPressed,
              onDisbandPartyButtonPressed: onDisbandPartyButtonPressed,
              onRecruitButtonPressed: onRecruitButtonPressed,
            ),
          ),
        ],
      ),
    );
  }

  void onSearchButtonPressed() {}
  void onEditAnnouncementButtonPressed() {}
  void onDisbandPartyButtonPressed() {}
  void onRecruitButtonPressed() {}
}
