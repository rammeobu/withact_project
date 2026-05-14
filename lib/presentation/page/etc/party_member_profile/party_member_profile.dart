import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/etc/party_member_profile/party_member_profile_body1.dart';
import 'package:party_maker/presentation/page/etc/party_member_profile/party_member_profile_body2.dart';
import 'package:party_maker/presentation/page/etc/party_member_profile/party_member_profile_body3.dart';
import 'package:party_maker/presentation/page/etc/party_member_profile/party_member_profile_body4.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

class PartyMemberProfile extends StatefulWidget {
  final String? profileImage;
  final List<String> profileContent;
  final String introduction;
  final String spec;
  final List<String> preferences;
  final List<String> positions;
  const PartyMemberProfile({
    super.key,
    required this.profileContent,
    required this.introduction,
    required this.spec,
    required this.preferences,
    required this.positions,
    this.profileImage,
  });

  @override
  State<PartyMemberProfile> createState() => _PartyMemberProfileState();
}

class _PartyMemberProfileState extends State<PartyMemberProfile> {
  late List<ScrollController> scrollControllers;

  @override
  void initState() {
    super.initState();
    scrollControllers = List.generate(4, (_) => ScrollController());
  }

  @override
  void dispose() {
    for (ScrollController controller in scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BasicLayout(
      title: '파티원 프로필',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Expanded(
          child: SingleChildScrollView(
            controller: scrollControllers[0],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PartyMemberProfileBody1(
                  name: widget.profileContent[0],
                  role: widget.profileContent[1],
                  onCallButtonPressed: onCallButtonPressed,
                ),
                PartyMemberProfileBody2(
                  section: '소개',
                  content: widget.introduction,
                  scrollController: scrollControllers[1],
                ),
                PartyMemberProfileBody2(
                  section: '스펙',
                  content: widget.spec,
                  scrollController: scrollControllers[2],
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: const Text(
                    '선호 활동 정보',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                PartyMemberProfileBody3(
                  preferenceRole: widget.preferences[0],
                  preferenceField: widget.preferences[1],
                  preferenceDomain: widget.preferences[2],
                ),
                // 1~3까지 dialog로 한 화면 내에서 띄우고 해당 페이지는 제거될 수도 있음.
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: const Text(
                    '파티원 목록',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                PartyMemberProfileBody4(
                  position: widget.positions,
                  onPersonPressed: onPersonPressed,
                  scrollController: scrollControllers[3],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: true,
    );
  }

  void onCallButtonPressed() {}
  void onPersonPressed(String id) {}
}
