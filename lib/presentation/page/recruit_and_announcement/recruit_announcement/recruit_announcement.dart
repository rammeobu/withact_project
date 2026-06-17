import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/recruit_announcement/recruit_announcement_body2.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/recruit_announcement/recruit_announcement_body3.dart';
import '../../future&component/layout/basic_layout.dart';
import 'recruit_announcement_body.dart';
import 'recruit_announcement_footer.dart';

class RecruitAnnouncement extends ConsumerStatefulWidget {
  final List<String>? preferences;
  final List<String> position;
  final String activityName;
  final String partyNameIntroduction;
  final int partyId;
  const RecruitAnnouncement({
    super.key,
    this.preferences,
    required this.activityName,
    required this.partyNameIntroduction,
    required this.position,
    required this.partyId,
  });

  @override
  ConsumerState<RecruitAnnouncement> createState() =>
      RecruitAnnouncementState();
}

class RecruitAnnouncementState extends ConsumerState<RecruitAnnouncement> {
  late List<ScrollController> scrollControllers;
  late String activityName;
  late String partyNameIntroduction;
  late List<String> position;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    scrollControllers = List.generate(5, (_) => ScrollController());
    activityName = widget.activityName;
    partyNameIntroduction = widget.partyNameIntroduction;
    position = widget.position;
    fetchAnnouncement();
  }

  Future<void> fetchAnnouncement() async {
    if (widget.partyId == 0) {
      if (mounted) setState(() => isLoading = false);
      return;
    }
    try {
      final detail = await ref
          .read(recruitRepositoryProvider)
          .getAnnouncement(widget.partyId.toString());
      if (!mounted) return;
      setState(() {
        if (detail.activityName.isNotEmpty) activityName = detail.activityName;
        if (detail.partyNameIntroduction.isNotEmpty) {
          partyNameIntroduction = detail.partyNameIntroduction;
        }
        if (detail.position.isNotEmpty) position = detail.position;
        isLoading = false;
      });
    } catch (_) {
      if (mounted) setState(() => isLoading = false);
    }
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
    final double screenWidth = MediaQuery.of(context).size.width;
    return BasicLayout(
      title: '모집 공고',
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: appPrimaryColor),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollControllers[0],
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.036,
                        top: 13,
                        right: screenWidth * 0.036,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RecruitAnnouncementBody(
                            section: '활동 이름',
                            content: activityName,
                            onSearchButtonPressed: onSearchButtonPressed,
                            scrollController: scrollControllers[1],
                          ),
                          RecruitAnnouncementBody(
                            section: '파티 이름/소개',
                            content: partyNameIntroduction,
                            scrollController: scrollControllers[2],
                          ),
                          RecruitAnnouncementBody2(
                            preferences: widget.preferences,
                            scrollController: scrollControllers[3],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 23),
                            child: RecruitAnnouncementBody3(
                              position: position,
                              primaryScrollController: scrollControllers[0],
                              horizontalScrollController: scrollControllers[4],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.036,
                    vertical: 6,
                  ),
                  child: RecruitAnnouncementFooter(
                    onEditAnnouncementButtonPressed:
                        onEditAnnouncementButtonPressed,
                    onDisbandPartyButtonPressed: onDisbandPartyButtonPressed,
                    onRecruitButtonPressed: onRecruitButtonPressed,
                  ),
                ),
              ],
            ),
      bottomNavigationBar: false,
    );
  }

  void onSearchButtonPressed() {
    Navigator.pushNamed(context, PageRoutes.findActivity);
  }

  void onEditAnnouncementButtonPressed() {
    Navigator.pushNamed(
      context,
      PageRoutes.announcementEdit,
      arguments: {
        'activityName': activityName,
        'partyNameIntroduction': partyNameIntroduction,
        'positions': position,
        'preferences': widget.preferences,
        'partyId': widget.partyId,
      },
    );
  }

  void onDisbandPartyButtonPressed() {
    Navigator.pushNamed(
      context,
      PageRoutes.disbandDoubleCheck,
      arguments: {'partyId': widget.partyId},
    );
  }

  void onRecruitButtonPressed() {
    Navigator.pop(context);
  }
}
