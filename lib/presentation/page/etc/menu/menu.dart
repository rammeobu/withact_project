import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_body1.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_body2.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_body3.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_body4.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

class Menu extends StatelessWidget {
  final String? profileImage;
  final String name;
  const Menu({super.key, this.profileImage, required this.name});

  @override
  Widget build(BuildContext context) {
    return BasicLayout(
      needTitleExpand: true,
      needWidget: [
        Container(
          width: 45.0,
          height: 45.0,
          decoration: const BoxDecoration(
            color: Color(0xFFECEEFD),
            shape: BoxShape.circle,
          ),
          child: (profileImage != null)
              ? Image.file(File(profileImage!), fit: BoxFit.cover)
              : const Icon(Icons.person, size: 45, color: Color(0xFF5764F0)),
        ),
        const SizedBox(width: 20.0),
        Text('$name 님', style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
      actions: [
        OutlinedButton(
          onPressed: onLogoutButtonPressed,
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            fixedSize: const Size(80, 35),
            side: const BorderSide(width: 0.0, color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10.0),
            ),
            foregroundColor: Colors.white,
          ),
          child: const Text(
            '로그아웃',
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w300),
          ),
        ),
        SizedBox(width: 10.0),
      ],
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MenuBody1(
                    personalInformationManagementMenuSelect:
                        personalInformationManagementMenuSelect,
                    profileAndDetailManagementMenuSelect:
                        profileAndDetailManagementMenuSelect,
                  ),
                  MenuBody2(
                    recentlySearchedWorkMenuSelect:
                        recentlySearchedWorkMenuSelect,
                    participatingWorkMenuSelect: participatingWorkMenuSelect,
                    findWorkMenuSelect: findWorkMenuSelect,
                  ),
                  MenuBody3(applyingWorkMenuSelect: applyingWorkMenuSelect),
                  MenuBody4(
                    recruitingWorkMenuSelect: recruitingWorkMenuSelect,
                    recruitAnnouncementManagementMenuSelect:
                        recruitAnnouncementManagementMenuSelect,
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

  void onLogoutButtonPressed() {}
  void personalInformationManagementMenuSelect() {}
  void profileAndDetailManagementMenuSelect() {}
  void recentlySearchedWorkMenuSelect() {}
  void participatingWorkMenuSelect() {}
  void findWorkMenuSelect() {}
  void applyingWorkMenuSelect() {}
  void recruitingWorkMenuSelect() {}
  void recruitAnnouncementManagementMenuSelect() {}
}
