import 'package:flutter/material.dart';
import 'package:party_maker/page/screen_design_1/work_information/work_information_body1.dart';
import 'package:party_maker/page/screen_design_1/work_information/work_information_body2.dart';
import '../../future&component/layout/default_container.dart';
import '../../future&component/layout/basic_layout.dart';
import '../../future&component/profile/profile_card_leader.dart';


class WorkInformation extends StatefulWidget {
  final String workOverview;
  final String workDetail;
  final List<String> leaderProfile;
  final List<String> position;
  const WorkInformation({
    super.key,
    required this.workOverview,
    required this.workDetail,
    required this.leaderProfile,
    required this.position
  });

  @override
  State<WorkInformation> createState() => _WorkInformationState();
}

class _WorkInformationState extends State<WorkInformation> {
  @override
  Widget build(BuildContext context) {
    return BasicLayout(
      title: '활동 정보',
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WorkInformationBody1(workOverview: widget.workOverview),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Text(
                '상세설명',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: DefaultContainer(
                width: MediaQuery.of(context).size.width,
                height: 150,
                color: Color(0xFFF7F8F9),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      child: Text(
                        widget.workDetail,
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ProfileCardLeader(profileContent: widget.leaderProfile),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Text(
                '현재 파티원 목록',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
              ),
            ),
            WorkInformationBody2(position: widget.position),
            SizedBox(height: 40.0),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 0.0),
                padding: EdgeInsets.zero,
                minimumSize: Size(0, 0),
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(15.0),
                ),
                backgroundColor: Color(0xff5764f0),
                foregroundColor: Colors.white,
              ),
              onPressed: () {},
              child: Text(
                '지원자 확인하기',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
