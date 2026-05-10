import 'package:flutter/material.dart';
import '../../future&component/component/when_to_meet.dart';
import '../../future&component/layout/basic_layout.dart';
import 'applicant_profile_body1.dart';
import 'applicant_profile_footer.dart';

class ApplicantProfile extends StatefulWidget {
  final String name;
  final List<String> profile;
  const ApplicantProfile({
    super.key,
    required this.name,
    required this.profile,
  });

  @override
  State<ApplicantProfile> createState() => _ApplicantProfileState();
}

class _ApplicantProfileState extends State<ApplicantProfile> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
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
                      content: widget.profile[0],
                    ),
                    ApplicantProfileBody1(
                      section: '스펙',
                      content: widget.profile[1],
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
                    const SizedBox(
                      height: 350.0,
                      child: WhenToMeet(readOnly: true),
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
