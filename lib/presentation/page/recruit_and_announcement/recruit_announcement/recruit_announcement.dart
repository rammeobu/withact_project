import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/recruit_announcement/recruit_announcement_body2.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/recruit_announcement/recruit_announcement_body3.dart';
import '../../future&component/layout/basic_layout.dart';
import 'recruit_announcement_body.dart';
import 'recruit_announcement_footer.dart';

class RecruitAnnouncement extends StatefulWidget {
  final List<String>? preferences;
  final List<String> position;
  final String workName;
  final String partyNameIntroduction;
  const RecruitAnnouncement({
    super.key,
    this.preferences,
    required this.workName,
    required this.partyNameIntroduction,
    required this.position,
  });

  @override
  State<RecruitAnnouncement> createState() => _RecruitAnnouncementState();
}

class _RecruitAnnouncementState extends State<RecruitAnnouncement> {
  late List<ScrollController> scrollControllers;

  @override
  void initState() {
    super.initState();
    scrollControllers = List.generate(5, (_) => ScrollController());
  }

  @override
  void dispose() {
    for (ScrollController controller in scrollControllers) {
      controller.dispose();
    }
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
              controller: scrollControllers[0],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RecruitAnnouncementBody(
                      section: '활동 이름',
                      content: widget.workName,
                      onSearchButtonPressed: onSearchButtonPressed,
                      scrollController: scrollControllers[1],
                    ),
                    RecruitAnnouncementBody(
                      section: '파티 이름/소개',
                      content: widget.partyNameIntroduction,
                      scrollController: scrollControllers[2],
                    ),
                    RecruitAnnouncementBody2(
                      preferences: widget.preferences,
                      scrollController: scrollControllers[3],
                    ),
                    const SizedBox(height: 20.0),
                    RecruitAnnouncementBody3(
                      position: widget.position,
                      primaryScrollController: scrollControllers[0],
                      horizontalScrollController: scrollControllers[4],
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
      bottomNavigationBar: false,
    );
  }

  void onSearchButtonPressed() {}
  void onEditAnnouncementButtonPressed() {}
  void onDisbandPartyButtonPressed() {}
  void onRecruitButtonPressed() {}
}
