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
  late ScrollController _scrollController;
  late ScrollController _whenToMeetScrollController;
  late List<ScrollController> body1ScrollControllers;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    body1ScrollControllers = List.generate(2, (_) => ScrollController());
    _whenToMeetScrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _whenToMeetScrollController.dispose();
    for (ScrollController controller in body1ScrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BasicLayout(
      title: '지원자 프로필',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                      ),
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 25.0,
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
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        '활동 가능 시간',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 350.0,
                      child: WhenToMeet(
                        readOnly: true,
                        scrollController: _whenToMeetScrollController,
                      ),
                    ),
                    const SizedBox(height: 40.0),
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
  }

  void onGoBackApplicantListButtonPressed() {}
}
