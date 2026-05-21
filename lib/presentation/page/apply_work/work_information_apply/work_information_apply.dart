import 'package:flutter/material.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/screen_design_1/work_information/work_information_body1.dart';
import 'package:party_maker/presentation/page/apply_work/work_information_apply/work_information_apply_body2.dart';
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

class WorkInformationApply extends StatefulWidget {
  final String workName;
  final String workOverview;
  final String workDetail;
  final String? poster;
  final List<String> leaderProfile;
  final List<String> position;
  final List<bool>? positionOccupy;

  const WorkInformationApply({
    super.key,
    required this.workName,
    required this.workOverview,
    required this.workDetail,
    required this.leaderProfile,
    required this.position,
    this.poster,
    this.positionOccupy,
  });

  @override
  State<WorkInformationApply> createState() => _WorkInformationApplyState();
}

class _WorkInformationApplyState extends State<WorkInformationApply> {
  late ScrollController detailScrollController;
  late ScrollController body1ScrollController;

  @override
  void initState() {
    super.initState();
    detailScrollController = ScrollController();
    body1ScrollController = ScrollController();
  }

  @override
  void dispose() {
    detailScrollController.dispose();
    body1ScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return BasicLayout(
      title: '활동 정보',
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.049,
                  top: 13,
                  right: screenWidth * 0.049,
                  bottom: 23,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    WorkInformationBody1(
                      workOverview: widget.workName,
                      poster: widget.poster,
                      scrollController: body1ScrollController,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: Text(
                        '요약설명',
                        style: TextStyle(
                          fontSize: screenWidth * 0.044,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: DefaultContainer(
                        width: double.infinity,
                        height: 101,
                        color: const Color(0xFFF0F2F5),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.029),
                          child: SingleChildScrollView(
                            child: Text(
                              widget.workOverview,
                              style: TextStyle(
                                fontSize: screenWidth * 0.034,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: Text(
                        '상세설명',
                        style: TextStyle(
                          fontSize: screenWidth * 0.044,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: DefaultContainer(
                        width: double.infinity,
                        height: 211,
                        color: const Color(0xFFF7F8F9),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.029),
                          child: Scrollbar(
                            controller: detailScrollController,
                            child: SingleChildScrollView(
                              controller: detailScrollController,
                              child: Text(
                                widget.workDetail,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.036,
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
                      padding: const EdgeInsets.only(top: 17),
                      child: Text(
                        '현재 파티원 목록',
                        style: TextStyle(
                          fontSize: screenWidth * 0.044,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    WorkInformationApplyBody2(
                      position: widget.position,
                      onPersonPressed: onPersonPressed,
                      positionOccupy: widget.positionOccupy,
                    ),

                    const SizedBox(height: 17),
                  ],
                ),
              ),
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              fixedSize: Size(screenWidth, 57),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.036),
              ),
              backgroundColor: appPrimaryColor,
              foregroundColor: Colors.white,
              side: BorderSide.none,
            ),
            onPressed: onApplyButtonPressed,
            child: Text(
              '지원하기',
              style: TextStyle(
                fontSize: screenWidth * 0.044,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: false,
    );
  }

  void onCallButtonPressed() {
    // TODO: 백엔드와 협의 후 문의하기 기능에 대한 구체화 이후 문의하기 기능에 대한 페이지 구현 후 해당 페이지로의 라우팅 수행
  }

  void onPersonPressed(String positionName) {
    Navigator.pushNamed(
      context,
      PageRoutes.partyMemberProfile,
      arguments: {
        'profileContent': List.generate(2, (i) => i == 1 ? positionName : ''),
        'introduction': '',
        'spec': '',
        'preferences': List.generate(3, (_) => ''),
        'positions': widget.position,
      },
    );
  }

  void onApplyButtonPressed() {
    const bool succeeded = true;
    Navigator.pushNamed(
      context,
      succeeded ? PageRoutes.applySuccess : PageRoutes.applyFail,
    );
  }
}
