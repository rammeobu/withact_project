import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import '../../future&component/component/when_to_meet.dart';
import '../../future&component/layout/basic_layout.dart';
import 'applicant_profile_body1.dart';
import 'applicant_profile_footer.dart';

class ApplicantProfile extends ConsumerStatefulWidget {
  final String name;
  final String introduction;
  final String spec;
  final int applicationId;
  final int applicantUserId;
  final int partyId;
  const ApplicantProfile({
    super.key,
    required this.name,
    required this.introduction,
    required this.spec,
    required this.applicationId,
    this.applicantUserId = 0,
    this.partyId = 0,
  });

  @override
  ConsumerState<ApplicantProfile> createState() => ApplicantProfileState();
}

class ApplicantProfileState extends ConsumerState<ApplicantProfile> {
  late ScrollController scrollController;
  late ScrollController whenToMeetOuterScrollController;
  late ScrollController whenToMeetScrollController;
  late List<ScrollController> body1ScrollControllers;
  late TextEditingController timeTextController;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    body1ScrollControllers = List.generate(2, (_) => ScrollController());
    whenToMeetOuterScrollController = ScrollController();
    timeTextController = TextEditingController();
    whenToMeetScrollController = ScrollController();
    fetchAvailableTime();
  }

  Future<void> fetchAvailableTime() async {
    if (widget.applicantUserId == 0 || widget.partyId == 0) return;
    try {
      final announcement = await ref
          .read(recruitRepositoryProvider)
          .getAnnouncement('${widget.partyId}');
      final activityId = announcement.activityId;
      if (activityId == null) return;
      final schedule = await ref
          .read(applyRepositoryProvider)
          .getAvailableTime(widget.applicantUserId, activityId);
      if (mounted) {
        ref
            .read(whenToMeetAvailableTimesProvider.notifier)
            .setTimes(WhenToMeet.fromSchedule(schedule));
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    scrollController.dispose();
    whenToMeetOuterScrollController.dispose();
    for (ScrollController controller in body1ScrollControllers) {
      controller.dispose();
    }
    timeTextController.dispose();
    whenToMeetScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return BasicLayout(
      title: '지원자 프로필',
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.036),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      child: Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: screenWidth * 0.058,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    ApplicantProfileBody1(
                      section: '소개',
                      content: widget.introduction,
                      scrollController: body1ScrollControllers[0],
                    ),
                    ApplicantProfileBody1(
                      section: '스펙',
                      content: widget.spec,
                      scrollController: body1ScrollControllers[1],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        '활동 가능 시간',
                        style: TextStyle(
                          fontSize: screenWidth * 0.041,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 704,
                      child: WhenToMeet(
                        readOnly: true,
                        scrollController: whenToMeetOuterScrollController,
                        timeTextController: timeTextController,
                        whenToMeetScrollController: whenToMeetScrollController,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 46)),
                  ],
                ),
              ),
            ),
            ApplicantProfileFooter(
              onAcceptButtonPressed: isSubmitting ? null : onAcceptButtonPressed,
              onRejectButtonPressed: isSubmitting ? null : onRejectButtonPressed,
              onTextButtonPressed: onGoBackApplicantListButtonPressed,
            ),
          ],
        ),
      ),
      bottomNavigationBar: false,
    );
  }

  Future<void> onAcceptButtonPressed() async {
    if (isSubmitting) return;
    setState(() => isSubmitting = true);
    try {
      await ref.read(applyRepositoryProvider).putAccept(widget.applicationId);
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('${widget.name} 지원자 수락 완료'),
              backgroundColor: const Color(0xFF1AB97A),
            ),
          );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('승인 처리에 실패했습니다.')),
          );
        setState(() => isSubmitting = false);
      }
    }
  }

  Future<void> onRejectButtonPressed() async {
    if (isSubmitting) return;
    setState(() => isSubmitting = true);
    try {
      await ref.read(applyRepositoryProvider).putDeny(widget.applicationId);
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('${widget.name} 지원자 거절 완료'),
              backgroundColor: const Color(0xFFF34343),
            ),
          );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('거절 처리에 실패했습니다.')),
          );
        setState(() => isSubmitting = false);
      }
    }
  }

  void onGoBackApplicantListButtonPressed() {
    Navigator.pop(context);
  }
}
