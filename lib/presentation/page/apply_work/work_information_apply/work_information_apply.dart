import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/screen_design_1/work_information/work_information_body1.dart';
import 'package:party_maker/presentation/page/screen_design_1/work_information/work_information_body2.dart';
import '../../future&component/layout/default_container.dart';
import '../../future&component/layout/basic_layout.dart';
import '../../future&component/profile/profile_card_leader.dart';

class WorkInformationApply extends StatefulWidget {
  final String workOverview;
  final String workDetail;
  final List<String> leaderProfile;
  final List<String> position;
  const WorkInformationApply({
    super.key,
    required this.workOverview,
    required this.workDetail,
    required this.leaderProfile,
    required this.position,
  });

  @override
  State<WorkInformationApply> createState() => _WorkInformationApplyState();
}

class _WorkInformationApplyState extends State<WorkInformationApply> {
  final List<ScrollController> _scrollControllers = [
    ScrollController(),
    ScrollController(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (ScrollController controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return BasicLayout(
      title: '활동 정보',
      body: Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          top: screenHeight * 0.02,
          right: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WorkInformationBody1(
              workOverview: widget.workOverview,
              scrollController: _scrollControllers[1],
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.012),
              child: const Text(
                '상세설명',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.012),
              child: DefaultContainer(
                width: MediaQuery.of(context).size.width,
                height: screenHeight * 0.14,
                color: const Color(0xFFF7F8F9),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Scrollbar(
                    controller: _scrollControllers[0],
                    child: SingleChildScrollView(
                      controller: _scrollControllers[0],
                      child: Text(
                        widget.workDetail,
                        style: const TextStyle(fontSize: 15.0),
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
              padding: EdgeInsets.only(top: screenHeight * 0.011),
              child: const Text(
                '현재 파티원 목록',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
              ),
            ),
            WorkInformationBody2(
              position: widget.position,
              onPersonPressed: onPersonPressed,
            ),
            SizedBox(height: screenHeight * 0.015),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(width: 0.0),
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(15.0),
                ),
                backgroundColor: const Color(0xff5764f0),
                foregroundColor: Colors.white,
              ),
              onPressed: checkApplicant,
              child: const Text(
                '지원하기',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: false,
    );
  }

  void onCallButtonPressed() {}
  void onPersonPressed(String id) {}
  void checkApplicant() {}
}
