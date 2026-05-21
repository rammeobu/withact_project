import 'package:flutter/material.dart';
import '../../future&component/component/when_to_meet.dart';
import '../../future&component/layout/basic_layout.dart';
import 'applicant_profile_body1.dart';
import 'applicant_profile_footer.dart';

class ApplicantProfile extends StatefulWidget {
  final String name;
  final String introduction;
  final String spec;
  const ApplicantProfile({
    super.key,
    required this.name,
    required this.introduction,
    required this.spec,
  });

  @override
  State<ApplicantProfile> createState() => _ApplicantProfileState();
}

class _ApplicantProfileState extends State<ApplicantProfile> {
  late ScrollController scrollController;
  late ScrollController whenToMeetOuterScrollController;
  late ScrollController whenToMeetScrollController;
  late List<ScrollController> body1ScrollControllers;
  late TextEditingController timeTextController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    body1ScrollControllers = List.generate(2, (_) => ScrollController());
    whenToMeetOuterScrollController = ScrollController();
    timeTextController = TextEditingController();
    whenToMeetScrollController = ScrollController();
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
              onAcceptButtonPressed: onAcceptButtonPressed,
              onRejectButtonPressed: onRejectButtonPressed,
              onTextButtonPressed: onGoBackApplicantListButtonPressed,
            ),
          ],
        ),
      ),
      bottomNavigationBar: false,
    );
  }

  void onAcceptButtonPressed() {
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

  void onRejectButtonPressed() {
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

  void onGoBackApplicantListButtonPressed() {
    Navigator.pop(context);
  }
}
