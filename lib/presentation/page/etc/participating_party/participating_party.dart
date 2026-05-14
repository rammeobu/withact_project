import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/etc/participating_party/participating_part_body2.dart';
import 'package:party_maker/presentation/page/etc/participating_party/participating_party_body1.dart';
import 'package:party_maker/presentation/page/etc/participating_party/participating_party_footer.dart';
import 'package:party_maker/presentation/page/screen_design_1/work_information/work_information_body1.dart';
import 'package:party_maker/presentation/page/screen_design_1/work_information/work_information_body2.dart';
import '../../future&component/layout/default_container.dart';
import '../../future&component/layout/basic_layout.dart';
import '../../future&component/profile/profile_card_leader.dart';

class Work {
  final String workName;
  final String workOverview;
  final String workDetail;
  final String? poster;

  Work({
    required this.workName,
    required this.workOverview,
    required this.workDetail,
    this.poster,
  });
}

class ParticipatingParty extends StatefulWidget {
  final String workName;
  final String workOverview;
  final String workDetail;
  final String? poster;
  final List<String> leaderProfile;
  final List<String> position;

  const ParticipatingParty({
    super.key,
    required this.workName,
    required this.workOverview,
    required this.workDetail,
    required this.leaderProfile,
    required this.position,
    this.poster,
  });

  @override
  State<ParticipatingParty> createState() => _ParticipatingPartyState();
}

class _ParticipatingPartyState extends State<ParticipatingParty> {
  late ScrollController _detailScrollController;
  late ScrollController _detailScrollController2;
  late ScrollController _body1ScrollController;

  @override
  void initState() {
    super.initState();
    _detailScrollController = ScrollController();
    _detailScrollController2 = ScrollController();
    _body1ScrollController = ScrollController();
  }

  @override
  void dispose() {
    _detailScrollController.dispose();
    _detailScrollController2.dispose();
    _body1ScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return BasicLayout(
      title: '참여 중인 파티',
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  top: screenHeight * 0.02,
                  right: 20.0,
                  bottom: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ParticipatingPartyBody1(
                      workOverview: widget.workName,
                      poster: widget.poster,
                      scrollController: _body1ScrollController,
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.02),
                      child: const Text(
                        '활동 개요',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.012),
                      child: DefaultContainer(
                        width: double.infinity,
                        height: screenHeight * 0.12,
                        color: const Color(0xFFF0F2F5),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SingleChildScrollView(
                            child: Text(
                              widget.workOverview,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.02),
                      child: const Text(
                        '활동 설명',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.012),
                      child: DefaultContainer(
                        width: double.infinity,
                        height: screenHeight * 0.25, // 높이 조절
                        color: const Color(0xFFF7F8F9),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Scrollbar(
                            controller: _detailScrollController,
                            child: SingleChildScrollView(
                              controller: _detailScrollController,
                              child: Text(
                                widget.workDetail,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  height: 1.6,
                                ),
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
                      padding: EdgeInsets.only(top: screenHeight * 0.02),
                      child: const Text(
                        '현재 파티원 목록',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    ParticipatingPartBody2(
                      position: widget.position,
                      onPersonPressed: onPersonPressed,
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

  void onCallButtonPressed() {}
  void onPersonPressed(String id) {}
  void onPartyExitButtonPressed() {}
}
