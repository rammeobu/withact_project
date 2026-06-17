import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/presentation/page/etc/participating_party/participating_part_body2.dart';
import 'package:party_maker/presentation/page/etc/participating_party/participating_party_footer.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';
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
  String activityOverview = '';
  List<String> leaderProfile = [];
  String? poster;

  @override
  void initState() {
    super.initState();
    detailScrollController = ScrollController();
    detailScrollController2 = ScrollController();
    body1ScrollController = ScrollController();
    activityDetail = widget.activityDetail;
    activityOverview = widget.activityOverview;
    leaderProfile = widget.leaderProfile;
    poster = widget.poster;
    fetchActivityDetail();
  }

  Future<void> fetchActivityDetail() async {
    final partyId = widget.partyId;
    if (partyId == null) return;
    try {
      final announcement =
          await ref.read(recruitRepositoryProvider).getAnnouncement('$partyId');
      if (mounted &&
          leaderProfile.isEmpty &&
          announcement.leaderProfile.isNotEmpty) {
        setState(() => leaderProfile = announcement.leaderProfile);
      }
      final activityId = announcement.activityId;
      if (activityId == null) return;
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
                    detailHero(
                      poster,
                      widget.activityName.isEmpty
                          ? '참여 중인 파티'
                          : widget.activityName,
                      screenWidth,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: sectionCard(screenWidth, [
                        sectionBlock(
                          screenWidth,
                          '활동 개요',
                          sectionText(activityOverview, screenWidth),
                        ),
                        sectionDivider(),
                        sectionBlock(
                          screenWidth,
                          '활동 설명',
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
