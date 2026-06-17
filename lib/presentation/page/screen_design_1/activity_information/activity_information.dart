import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/presentation/page/screen_design_1/activity_information/activity_information_body1.dart';
import 'package:party_maker/presentation/page/screen_design_1/activity_information/activity_information_body2.dart';
import '../../future&component/component/no_scale.dart';
import '../../future&component/component/role_progress_row.dart';
import '../../future&component/layout/default_container.dart';
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
  late String activityOverview;
  late String activityDetail;
  late List<String> position;
  late List<String> leaderProfile;
  List<int> targets = [];
  List<int> currents = [];
  bool rolesExpanded = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    detailScrollController = ScrollController();
    body1ScrollController = ScrollController();
    activityOverview = widget.activityOverview;
    activityDetail = widget.activityDetail;
    position = widget.position;
    leaderProfile = widget.leaderProfile;
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
      if (!mounted) return;
      setState(() {
        if (activityOverview.isEmpty &&
            detail.partyNameIntroduction.isNotEmpty) {
          activityOverview = detail.partyNameIntroduction;
        }
        if (position.isEmpty && detail.position.isNotEmpty) {
          position = detail.position;
        }
        if (leaderProfile.isEmpty && detail.leaderProfile.isNotEmpty) {
          leaderProfile = detail.leaderProfile;
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

    return BasicLayout(
      title: '활동 정보',
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
                          ActivityInformationBody1(
                            activityOverview: widget.activityName,
                            poster: widget.poster,
                            scrollController: body1ScrollController,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Text(
                              '요약설명',
                              style: TextStyle(
                                fontSize: screenWidth * 0.044,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: DefaultContainer(
                              width: double.infinity,
                              height: 101,
                              color: const Color(0xFFF0F2F5),
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.029),
                                child: SingleChildScrollView(
                                  child: NoScale(
                                    child: Text(
                                      activityOverview,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.034,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Text(
                              '상세설명',
                              style: TextStyle(
                                fontSize: screenWidth * 0.044,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: DefaultContainer(
                              width: double.infinity,
                              height: 211,
                              color: const Color(0xFFF7F8F9),
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.029),
                                child: Scrollbar(
                                  controller: detailScrollController,
                                  child: SingleChildScrollView(
                                    controller: detailScrollController,
                                    child: NoScale(
                                      child: Text(
                                        activityDetail,
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.036,
                                          height: 1.6,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ProfileCardLeader(
                            profileContent: leaderProfile,
                            onCallButtonPressed: onCallButtonPressed,
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
    final leaderName = leaderProfile.isNotEmpty ? leaderProfile[0] : '';
    final leaderSpec = leaderProfile.length > 1 ? leaderProfile[1] : '';
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('파티장 정보'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('이름: ${leaderName.isEmpty ? '-' : leaderName}'),
            const SizedBox(height: 6),
            Text('스펙: ${leaderSpec.isEmpty ? '-' : leaderSpec}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('닫기'),
          ),
        ],
      ),
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
