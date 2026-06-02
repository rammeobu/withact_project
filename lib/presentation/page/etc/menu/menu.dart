import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_body1.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_body2.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_body3.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_body4.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

class Menu extends StatefulWidget {
  final String? profileImage;
  final String name;
  const Menu({super.key, this.profileImage, required this.name});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return BasicLayout(
      needTitleExpand: true,
      needWidget: [
        Container(
          width: screenWidth * 0.109,
          height: screenWidth * 0.109,
          decoration: const BoxDecoration(
            color: Color(0xFFECEEFD),
            shape: BoxShape.circle,
          ),
          child: (widget.profileImage != null)
              ? Image.file(File(widget.profileImage!), fit: BoxFit.cover)
              : Icon(
                  Icons.person,
                  size: screenWidth * 0.109,
                  color: appPrimaryColor,
                ),
        ),
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.049),
          child: Text(
            '${widget.name} 님',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
      actions: [
        OutlinedButton(
          onPressed: onLogoutButtonPressed,
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            fixedSize: Size(screenWidth * 0.195, 41),
            side: const BorderSide(width: 0.0, color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(screenWidth * 0.024),
            ),
            foregroundColor: Colors.white,
          ),
          child: Text(
            '로그아웃',
            style: TextStyle(
              fontSize: screenWidth * 0.041,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MenuBody1(
                    personalInformationManagementMenuSelect:
                        onPersonalInformationManagementMenuSelect,
                    profileAndDetailManagementMenuSelect:
                        onProfileAndDetailManagementMenuSelect,
                  ),
                  MenuBody2(
                    recentlySearchedWorkMenuSelect:
                        onRecentlySearchedWorkMenuSelect,
                    participatingWorkMenuSelect: onParticipatingWorkMenuSelect,
                    findWorkMenuSelect: onFindWorkMenuSelect,
                  ),
                  MenuBody3(applyingWorkMenuSelect: onApplyingWorkMenuSelect),
                  MenuBody4(
                    recruitingWorkMenuSelect: onRecruitingWorkMenuSelect,
                    recruitAnnouncementManagementMenuSelect:
                        onRecruitAnnouncementManagementMenuSelect,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: true,
      menuSelected: true,
    );
  }

  void onLogoutButtonPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('로그아웃 하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                PageRoutes.login,
                (route) => false,
              );
            },
            child: const Text('예'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('아니오'),
          ),
        ],
      ),
    );
  }

  void onPersonalInformationManagementMenuSelect() {
    Navigator.pushNamed(context, PageRoutes.personalInfo);
  }

  void onProfileAndDetailManagementMenuSelect() {
    Navigator.pushNamed(
      context,
      PageRoutes.profileEdit,
      arguments: {
        'profileContent': List.generate(4, (i) => i == 0 ? widget.name : ''),
        'introduction': '',
        'spec': '',
        'favorites': <String>['', '', ''],
      },
    );
  }

  void onRecentlySearchedWorkMenuSelect() {}

  void onParticipatingWorkMenuSelect() {
    Navigator.pushNamed(
      context,
      PageRoutes.participatingParty,
      arguments: {
        'workName': '',
        'workOverview': '',
        'workDetail': '',
        'leaderProfile': <String>[],
        'position': <String>[],
        'poster': null,
      },
    );
  }

  void onFindWorkMenuSelect() {
    Navigator.pushNamed(context, PageRoutes.findWork);
  }

  void onApplyingWorkMenuSelect() {
    Navigator.pushNamed(context, PageRoutes.applyList);
  }

  void onRecruitingWorkMenuSelect() {
    Navigator.pushNamed(context, PageRoutes.recruitList);
  }

  void onRecruitAnnouncementManagementMenuSelect() {
    Navigator.pushNamed(context, PageRoutes.recruitManageSelect);
  }
}
