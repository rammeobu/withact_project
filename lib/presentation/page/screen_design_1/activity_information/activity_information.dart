import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';
import 'package:party_maker/presentation/page/screen_design_1/activity_information/activity_information_body2.dart';
import '../../future&component/component/role_progress_row.dart';
import '../../future&component/layout/basic_layout.dart';
import '../../future&component/profile/profile_card_leader.dart';

class ActivityInformation extends ConsumerStatefulWidget {
  final String activityName;
  final String activityOverview;
  final String activityDetail;
  final String? poster;
  final List<String> leaderProfile;
  final List<String> position;
  final List<bool>? positionOccupy;
  final int? partyId;

  const ActivityInformation({
    super.key,
    required this.activityName,
    required this.activityOverview,
    required this.activityDetail,
    required this.leaderProfile,
    required this.position,
    this.poster,
    this.positionOccupy,
    this.partyId,
  });

  @override
  ConsumerState<ActivityInformation> createState() =>
      ActivityInformationState();
}

class ActivityInformationState extends ConsumerState<ActivityInformation> {
  late ScrollController detailScrollController;
  late ScrollController body1ScrollController;
  late String activityName;
  late String activityOverview;
  late String activityDetail;
  late List<String> position;
  late List<String> leaderProfile;
  String? poster;
  List<int> targets = [];
  List<int> currents = [];
  bool rolesExpanded = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    detailScrollController = ScrollController();
    body1ScrollController = ScrollController();
    activityName = widget.activityName;
    activityOverview = widget.activityOverview;
    activityDetail = widget.activityDetail;
    position = widget.position;
    leaderProfile = widget.leaderProfile;
    poster = widget.poster;
    fetchDetail();
  }

  Future<void> fetchDetail() async {
    final id = widget.partyId;
    if (id == null || id == 0) {
      if (mounted) setState(() => isLoading = false);
      return;
    }
    try {
      final detail = await ref
          .read(recruitRepositoryProvider)
          .getAnnouncement(id.toString());
      String? fetchedPoster;
      if ((poster == null || poster!.isEmpty) && detail.activityId != null) {
        try {
          final actData = await ref
              .read(findRepositoryProvider)
              .getActivityDetail('${detail.activityId}');
          fetchedPoster = actData['imageUrl']?.toString();
        } catch (_) {}
      }
      if (!mounted) return;
      setState(() {
        if (activityOverview.isEmpty &&
            detail.partyNameIntroduction.isNotEmpty) {
          activityOverview = detail.partyNameIntroduction;
        }
        if (activityName.isEmpty && detail.activityName.isNotEmpty) {
          activityName = detail.activityName;
        }
        if (position.isEmpty && detail.position.isNotEmpty) {
          position = detail.position;
        }
        if (leaderProfile.isEmpty && detail.leaderProfile.isNotEmpty) {
          leaderProfile = detail.leaderProfile;
        }
        if (fetchedPoster != null && fetchedPoster.isNotEmpty) {
          poster = fetchedPoster;
        }
        targets = detail.targets;
        currents = detail.currents;
        isLoading = false;
      });
    } catch (_) {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    detailScrollController.dispose();
    body1ScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isParty = widget.partyId != null && widget.partyId != 0;

    return BasicLayout(
      title: isParty ? '파티 정보' : '활동 정보',
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: appPrimaryColor),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.049,
                        top: 13,
                        right: screenWidth * 0.049,
                        bottom: 23,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          detailHero(
                            poster,
                            activityName.isEmpty ? '활동 정보' : activityName,
                            screenWidth,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: sectionCard(screenWidth, [
                              sectionBlock(
                                screenWidth,
                                '요약',
                                sectionText(activityOverview, screenWidth),
                              ),
                              sectionDivider(),
                              sectionBlock(
                                screenWidth,
                                '상세',
                                sectionText(activityDetail, screenWidth),
                              ),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: ProfileCardLeader(
                              profileContent: leaderProfile,
                              onCallButtonPressed: onCallButtonPressed,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '현재 파티원 목록',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.044,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.03),
                                Expanded(
                                  child: AnimatedSize(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeInOut,
                                    alignment: Alignment.topCenter,
                                    child: Column(
                                      children: [
                                        ...position
                                            .asMap()
                                            .entries
                                            .take(
                                              rolesExpanded
                                                  ? position.length
                                                  : 2,
                                            )
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
                                              return RoleProgressRow(
                                                roleName: entry.value,
                                                target: target,
                                                current: current,
                                                fontSize: screenWidth * 0.032,
                                              );
                                            }),
                                        if (position.length > 2)
                                          InkWell(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            onTap: () {
                                              HapticFeedback.selectionClick();
                                              setState(
                                                () => rolesExpanded =
                                                    !rolesExpanded,
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 2,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    rolesExpanded
                                                        ? '접기'
                                                        : '더보기',
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenWidth * 0.030,
                                                      color: const Color(
                                                        0xFF636370,
                                                      ),
                                                    ),
                                                  ),
                                                  Icon(
                                                    rolesExpanded
                                                        ? Icons
                                                              .keyboard_arrow_up
                                                        : Icons
                                                              .keyboard_arrow_down,
                                                    size: screenWidth * 0.045,
                                                    color: const Color(
                                                      0xFF636370,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 17),
                            child: ActivityInformationBody2(
                              position: position,
                              currents: currents,
                              onPersonPressed: onPersonPressed,
                              positionOccupy: widget.positionOccupy,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: false,
    );
  }

  void onCallButtonPressed() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('문의 기능은 준비 중입니다.')),
      );
  }

  void onPersonPressed(String positionName) {
    Navigator.pushNamed(
      context,
      PageRoutes.partyMemberProfile,
      arguments: {
        'profileContent': List.generate(2, (i) => i == 1 ? positionName : ''),
        'introduction': '',
        'spec': '',
        'preferences': List.generate(3, (_) => ''),
        'positions': position,
      },
    );
  }
}
