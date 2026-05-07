import 'package:flutter/material.dart';
import '../../future&component/component/when_to_meet.dart';
import '../../future&component/layout/basic_layout.dart';
import 'applicant_profile_body1.dart';
import 'applicant_profile_footer.dart';

class ApplicantProfile extends StatefulWidget {
  final String name;
  final List<String> profile;
  const ApplicantProfile({super.key, required this.name, required this.profile});

  @override
  State<ApplicantProfile> createState() => _ApplicantProfileState();
}

class _ApplicantProfileState extends State<ApplicantProfile> {
  @override
  Widget build(BuildContext context) {
    return BasicLayout(
      title: '지원자 프로필',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                widget.name,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w900),
              ),
            ),
            ApplicantProfileBody1(section: '소개', content: widget.profile[0]),
            ApplicantProfileBody1(section: '스펙', content: widget.profile[1]),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                '활동 가능 시간',
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(child: WhenToMeet(readOnly: true)),
            SizedBox(height: 50.0),
            ApplicantProfileFooter(
              onAcceptButtonPressed: () {},
              onRejectButtonPressed: () {},
              onTextButtonPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
