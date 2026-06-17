import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/find_data_structures.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_body1.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_body2.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_body3.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_body4.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

class Menu extends ConsumerStatefulWidget {
  final String? profileImage;
  final String name;
  const Menu({super.key, this.profileImage, required this.name});

  @override
  ConsumerState<Menu> createState() => MenuState();
}

class MenuState extends ConsumerState<Menu> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final profile = ref.watch(profileProvider);
    final name =
        profile.profileContent.isNotEmpty && profile.profileContent[0].isNotEmpty
        ? profile.profileContent[0]
        : widget.name;
    final profileImage = profile.imagePath ?? widget.profileImage;
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
          child: (profileImage != null)
              ? Image.file(File(profileImage), fit: BoxFit.cover, cacheWidth: 300)
              : Icon(
                  Icons.person,
                  size: screenWidth * 0.109,
                  color: appPrimaryColor,
                ),
        ),
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.049),
          child: Text(
            '$name 님',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w800,
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
                    recentlySearchedActivityMenuSelect:
                        onRecentlySearchedActivityMenuSelect,
                    participatingActivityMenuSelect: onParticipatingActivityMenuSelect,
                    findActivityMenuSelect: onFindActivityMenuSelect,
                    findPartyMenuSelect: onFindPartyMenuSelect,
                  ),
                  MenuBody3(applyingActivityMenuSelect: onApplyingActivityMenuSelect),
                  MenuBody4(
                    recruitingActivityMenuSelect: onRecruitingActivityMenuSelect,
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

  void onRecentlySearchedActivityMenuSelect() {
    Navigator.pushNamed(context, PageRoutes.recentSearchedActivity);
  }

  void onParticipatingActivityMenuSelect() {
    Navigator.pushNamed(context, PageRoutes.participatingList);
  }

  void onFindActivityMenuSelect() {
    Navigator.pushNamed(context, PageRoutes.findActivity);
  }

  void onFindPartyMenuSelect() {
    Navigator.pushNamed(
      context,
      PageRoutes.findParty,
      arguments: {'partyList': <PartyItem>[]},
    );
  }

  void onApplyingActivityMenuSelect() {
    Navigator.pushNamed(context, PageRoutes.applyList);
  }

  void onRecruitingActivityMenuSelect() {
    Navigator.pushNamed(context, PageRoutes.recruitList);
  }

  void onRecruitAnnouncementManagementMenuSelect() {
    Navigator.pushNamed(context, PageRoutes.recruitManageSelect);
  }
}
