import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';
import '../../future&component/component/role_progress_row.dart';
import '../../future&component/layout/basic_layout.dart';
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
  late ScrollController scrollController;
  late String activityName;
  late String partyNameIntroduction;
  late List<String> position;
  late List<String> preferences;
  List<int> targets = [];
  List<int> currents = [];
  String? poster;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    activityName = widget.activityName;
    partyNameIntroduction = widget.partyNameIntroduction;
    position = widget.position;
    preferences = widget.preferences ?? [];
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
      String? fetchedPoster;
      if (detail.activityId != null) {
        try {
          final actData = await ref
              .read(findRepositoryProvider)
              .getActivityDetail('${detail.activityId}');
          fetchedPoster = actData['imageUrl']?.toString();
        } catch (_) {}
      }
      if (!mounted) return;
      setState(() {
        if (detail.activityName.isNotEmpty) activityName = detail.activityName;
        if (detail.partyNameIntroduction.isNotEmpty) {
          partyNameIntroduction = detail.partyNameIntroduction;
        }
        if (detail.position.isNotEmpty) position = detail.position;
        targets = detail.targets;
        currents = detail.currents;
        if (fetchedPoster != null && fetchedPoster.isNotEmpty) {
          poster = fetchedPoster;
        }
        isLoading = false;
      });
    } catch (_) {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
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
                    controller: scrollController,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.045,
                        top: 14,
                        right: screenWidth * 0.045,
                        bottom: 18,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          detailHero(
                            poster,
                            activityName.isEmpty ? '모집 공고' : activityName,
                            screenWidth,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: sectionCard(screenWidth, [
                              sectionBlock(
                                screenWidth,
                                '파티 소개',
                                sectionText(partyNameIntroduction, screenWidth),
                              ),
                              sectionDivider(),
                              sectionBlock(
                                screenWidth,
                                '우대사항',
                                preferences.where((p) => p.trim().isNotEmpty).isEmpty
                                    ? sectionText('', screenWidth)
                                    : cardRoleChips(
                                        preferences
                                            .where((p) => p.trim().isNotEmpty)
                                            .toList(),
                                        screenWidth,
                                      ),
                              ),
                              sectionDivider(),
                              sectionBlock(
                                screenWidth,
                                '모집 역할 / 인원',
                                position.isEmpty
                                    ? sectionText('', screenWidth)
                                    : Column(
                                        children: position
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                              final int i = entry.key;
                                              final int target =
                                                  i < targets.length
                                                  ? targets[i]
                                                  : 1;
                                              final int current =
                                                  i < currents.length
                                                  ? currents[i]
                                                  : 0;
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 6,
                                                ),
                                                child: RoleProgressRow(
                                                  roleName: entry.value,
                                                  target: target,
                                                  current: current,
                                                  fontSize: screenWidth * 0.034,
                                                ),
                                              );
                                            })
                                            .toList(),
                                      ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.045,
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

  void onEditAnnouncementButtonPressed() {
    Navigator.pushNamed(
      context,
      PageRoutes.announcementEdit,
      arguments: {
        'activityName': activityName,
        'partyNameIntroduction': partyNameIntroduction,
        'positions': position,
        'preferences': preferences,
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
