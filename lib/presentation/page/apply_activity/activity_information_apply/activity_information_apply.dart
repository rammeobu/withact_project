import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/find_data_structures.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';
import 'package:party_maker/presentation/page/apply_activity/activity_information_apply/activity_information_apply_body2.dart';
import '../../future&component/component/role_progress_row.dart';
import '../../future&component/layout/basic_layout.dart';
import '../../future&component/profile/profile_card_leader.dart';

class ActivityInformationApply extends ConsumerStatefulWidget {
  final String activityName;
  final String activityOverview;
  final String activityDetail;
  final String? poster;
  final List<String> leaderProfile;
  final List<String> position;
  final List<bool>? positionOccupy;
  final int? partyId;
  final int? activityId;

  const ActivityInformationApply({
    super.key,
    required this.activityName,
    required this.activityOverview,
    required this.activityDetail,
    required this.leaderProfile,
    required this.position,
    this.poster,
    this.positionOccupy,
    this.partyId,
    this.activityId,
  });

  @override
  ConsumerState<ActivityInformationApply> createState() =>
      ActivityInformationApplyState();
}

class ActivityInformationApplyState
    extends ConsumerState<ActivityInformationApply> {
  late ScrollController detailScrollController;
  late ScrollController body1ScrollController;
  late String activityOverview;
  late String activityDetail;
  late List<String> leaderProfile;
  String? poster;
  List<PartyRole> roles = [];
  bool rolesExpanded = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    detailScrollController = ScrollController();
    body1ScrollController = ScrollController();
    activityOverview = widget.activityOverview;
    activityDetail = widget.activityDetail;
    leaderProfile = widget.leaderProfile;
    poster = widget.poster;
    fetchRoles();
    fetchActivityDetail();
    fetchLeader();
  }

  Future<void> fetchLeader() async {
    final partyId = widget.partyId;
    if (partyId == null || leaderProfile.isNotEmpty) return;
    try {
      final announcement = await ref
          .read(recruitRepositoryProvider)
          .getAnnouncement('$partyId');
      if (mounted && announcement.leaderProfile.isNotEmpty) {
        setState(() => leaderProfile = announcement.leaderProfile);
      }
    } catch (_) {}
  }

  Future<void> fetchActivityDetail() async {
    final activityId = widget.activityId;
    if (activityId == null) return;
    try {
      final data = await ref
          .read(findRepositoryProvider)
          .getActivityDetail('$activityId');
      final detail = data['description']?.toString() ?? '';
      final fetchedPoster = data['imageUrl']?.toString();
      if (mounted) {
        setState(() {
          if (detail.isNotEmpty) {
            activityDetail = detail;
            if (activityOverview.trim().isEmpty) {
              activityOverview = summarize(detail);
            }
          }
          if ((poster == null || poster!.isEmpty) &&
              fetchedPoster != null &&
              fetchedPoster.isNotEmpty) {
            poster = fetchedPoster;
          }
        });
      }
    } catch (_) {}
  }

  String summarize(String text) {
    final firstLine = text
        .split('\n')
        .map((line) => line.trim())
        .firstWhere((line) => line.isNotEmpty, orElse: () => text.trim());
    return firstLine.length > 100 ? '${firstLine.substring(0, 100)}...' : firstLine;
  }

  Future<void> fetchRoles() async {
    final partyId = widget.partyId;
    if (partyId == null) {
      if (mounted) setState(() => isLoading = false);
      return;
    }
    try {
      final result = await ref
          .read(findRepositoryProvider)
          .getPartyRoles(partyId);
      if (mounted)
        setState(() {
          roles = result;
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

    return BasicLayout(
      title: '활동 정보',
      body: Column(
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
                      widget.activityName.isEmpty
                          ? '활동 정보'
                          : widget.activityName,
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
                            child: isLoading
                                ? const Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: appPrimaryColor,
                                      ),
                                    ),
                                  )
                                : AnimatedSize(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeInOut,
                                    alignment: Alignment.topCenter,
                                    child: Column(
                                      children: [
                                        ...roles
                                            .take(
                                              rolesExpanded ? roles.length : 2,
                                            )
                                            .map(
                                              (role) => RoleProgressRow(
                                                roleName: role.roleName,
                                                target: role.targetCount,
                                                current: role.currentCount,
                                                fontSize: screenWidth * 0.032,
                                              ),
                                            ),
                                        if (roles.length > 2)
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
                      child: ActivityInformationApplyBody2(
                        position: widget.position,
                        onPersonPressed: onPersonPressed,
                        positionOccupy: widget.positionOccupy,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              fixedSize: Size(screenWidth, 57),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.036),
              ),
              backgroundColor: appPrimaryColor,
              foregroundColor: Colors.white,
              side: BorderSide.none,
            ),
            onPressed: onApplyButtonPressed,
            child: Text(
              '지원하기',
              style: TextStyle(
                fontSize: screenWidth * 0.044,
                fontWeight: FontWeight.w700,
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
        'positions': widget.position,
      },
    );
  }

  void onApplyButtonPressed() {
    Navigator.pushNamed(
      context,
      PageRoutes.apply,
      arguments: {
        'activityName': widget.activityName,
        'profile': widget.leaderProfile,
        'poster': poster,
        'partyId': widget.partyId,
        'activityId': widget.activityId,
      },
    );
  }
}
