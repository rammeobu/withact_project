import 'package:flutter/material.dart';
import 'package:party_maker/page/apply_work/apply/apply_work_infomation.dart';

import '../../future&component/component/when_to_meet.dart';
import '../../future&component/layout/basic_layout.dart';
import '../../screen_design_1/work_information/work_information_body1.dart';
import 'apply_body1.dart';
import 'apply_footer.dart';

class Apply extends StatefulWidget {
  final String workName;
  final List<String> profile;
  const Apply({super.key, required this.workName, required this.profile});

  @override
  State<Apply> createState() => _ApplyState();
}

class _ApplyState extends State<Apply> {
  @override
  Widget build(BuildContext context) {
    return BasicLayout(
      title: '지원자 프로필',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ApplyWorkInformation(workOverview: widget.workName),
            ApplyBody(section: '소개', content: widget.profile[0]),
            ApplyBody(section: '스펙', content: widget.profile[1]),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                '활동 가능 시간',
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(child: WhenToMeet(readOnly: false)),
            SizedBox(height: 50.0),
            ApplyFooter(
              onAcceptButtonPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
