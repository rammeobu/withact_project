import 'package:flutter/material.dart';
import '../../future&component/component/when_to_meet.dart';
import '../../future&component/layout/basic_layout.dart';
import 'applying_work_body1.dart';
import 'applying_work_footer.dart';
import 'applying_work_information.dart';


class ApplyingWork extends StatefulWidget {
  final String workName;
  final List<String> profile;
  const ApplyingWork({super.key, required this.workName, required this.profile});

  @override
  State<ApplyingWork> createState() => _ApplicantProfileState();
}

class _ApplicantProfileState extends State<ApplyingWork> {
  @override
  Widget build(BuildContext context) {
    return BasicLayout(
      title: '지원 중인 활동',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ApplyingWorkInformation(workOverview: widget.workName),
            ),
            ApplyingWorkBody(section: '소개', content: widget.profile[0]),
            ApplyingWorkBody(section: '스펙', content: widget.profile[1]),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                '활동 가능 시간',
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(child: WhenToMeet(readOnly: true)),
            SizedBox(height: 50.0),
            ApplyingWorkFooter(
              onAcceptButtonPressed: () {},
              onRejectButtonPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
