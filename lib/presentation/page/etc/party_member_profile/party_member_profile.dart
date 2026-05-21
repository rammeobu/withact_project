import 'package:flutter/material.dart';
import 'package:party_maker/app.dart';
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
  final List<String> favorites;
  final List<String> positions;
  const PartyMemberProfile({
    super.key,
    required this.profileContent,
    required this.introduction,
    required this.spec,
    required this.favorites,
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
    final double screenWidth = MediaQuery.of(context).size.width;
    return BasicLayout(
      title: '파티원 프로필',
      body: Padding(
        padding: EdgeInsets.only(
          left: screenWidth * 0.036,
          top: 13,
          right: screenWidth * 0.036,
        ),
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
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '선호 활동 정보',
                    style: TextStyle(
                      fontSize: screenWidth * 0.041,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                PartyMemberProfileBody3(
                  favoriteRole: widget.favorites[0],
                  favoriteField: widget.favorites[1],
                  favoriteDomain: widget.favorites[2],
                ),
                // 1~3까지 dialog로 한 화면 내에서 띄우고 해당 페이지는 제거될 수도 있음.
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '파티원 목록',
                    style: TextStyle(
                      fontSize: screenWidth * 0.041,
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

  void onCallButtonPressed() {
    // TODO: 백엔드와 협의 후 문의하기 기능에 대한 구체화 이후 문의하기 기능에 대한 페이지 구현 후 해당 페이지로의 라우팅 수행
  }
  void onPersonPressed(String id) {
    Navigator.pushReplacementNamed(
      context,
      PageRoutes.partyMemberProfile,
      arguments: {
        'profileContent': List.generate(2, (i) => i == 1 ? id : ''),
        'introduction': '',
        'spec': '',
        'preferences': List.generate(3, (_) => ''),
        'positions': widget.positions,
      },
    );
  }
}
