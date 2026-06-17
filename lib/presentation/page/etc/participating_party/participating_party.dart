import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/presentation/page/etc/participating_party/participating_part_body2.dart';
import 'package:party_maker/presentation/page/etc/participating_party/participating_party_body1.dart';
import 'package:party_maker/presentation/page/etc/participating_party/participating_party_footer.dart';
import '../../future&component/layout/default_container.dart';
import '../../future&component/layout/basic_layout.dart';
import '../../future&component/profile/profile_card_leader.dart';

class ParticipatingParty extends ConsumerStatefulWidget {
  final String activityName;
  final String activityOverview;
  final String activityDetail;
  final String? poster;
  final List<String> leaderProfile;
  final List<String> position;
  final List<bool>? positionOccupy;
  final int? partyId;

  const ParticipatingParty({
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
  ConsumerState<ParticipatingParty> createState() => ParticipatingPartyState();
}

class ParticipatingPartyState extends ConsumerState<ParticipatingParty> {
  late ScrollController detailScrollController;
  late ScrollController detailScrollController2;
  late ScrollController body1ScrollController;
  String activityDetail = '';

  @override
  void initState() {
    super.initState();
    detailScrollController = ScrollController();
    detailScrollController2 = ScrollController();
    body1ScrollController = ScrollController();
    activityDetail = widget.activityDetail;
    fetchActivityDetail();
  }

  Future<void> fetchActivityDetail() async {
    final partyId = widget.partyId;
    if (partyId == null) return;
    try {
      final announcement =
          await ref.read(recruitRepositoryProvider).getAnnouncement('$partyId');
      final activityId = announcement.activityId;
      if (activityId == null) return;
      final data = await ref
          .read(findRepositoryProvider)
          .getActivityDetail('$activityId');
      final detail = data['description']?.toString() ?? '';
      if (mounted && detail.isNotEmpty) {
        setState(() => activityDetail = detail);
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    detailScrollController.dispose();
    detailScrollController2.dispose();
    body1ScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return BasicLayout(
      title: '참여 중인 파티',
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
                    ParticipatingPartyBody1(
                      activityOverview: widget.activityName,
                      poster: widget.poster,
                      scrollController: body1ScrollController,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: Text('활동 개요', style: subTitleFont),
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
                            child: Text(
                              widget.activityOverview,
                              style: TextStyle(
                                fontSize: screenWidth * 0.034,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: Text('활동 설명', style: subTitleFont),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: DefaultContainer(
                        width: double.infinity,
                        height: 211, // 높이 조절
                        color: const Color(0xFFF7F8F9),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.029),
                          child: Scrollbar(
                            controller: detailScrollController,
                            child: SingleChildScrollView(
                              controller: detailScrollController,
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

                    ProfileCardLeader(
                      profileContent: widget.leaderProfile,
                      onCallButtonPressed: onCallButtonPressed,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: Text('현재 파티원 목록', style: subTitleFont),
                    ),

                    ParticipatingPartBody2(
                      position: widget.position,
                      onPersonPressed: onPersonPressed,
                      positionOccupy: widget.positionOccupy,
                    ),
                  ],
                ),
              ),
            ),
          ),
          ParticipatingPartyFooter(
            onPartyExitButtonPressed: onPartyExitButtonPressed,
          ),
        ],
      ),
      bottomNavigationBar: false,
    );
  }

  void onCallButtonPressed() {
    // TODO: 백엔드와 협의 후 문의하기 기능에 대한 구체화 이후 문의하기 기능에 대한 페이지 구현 후 해당 페이지로의 라우팅 수행
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

  void onPartyExitButtonPressed() {
    Navigator.pushNamed(
      context,
      PageRoutes.partyExitDoubleCheck,
      arguments: {'partyId': widget.partyId},
    );
  }
}
