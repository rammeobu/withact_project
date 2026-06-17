import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

class PartyMemberProfileBody1 extends StatelessWidget {
  final String? profileImage;
  final VoidCallback onCallButtonPressed;
  final String name;
  final String role;

  const PartyMemberProfileBody1({
    super.key,
    required this.name,
    required this.role,
    required this.onCallButtonPressed,
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 160,
      child: Padding(
        padding: const EdgeInsets.only(top: 13),
        child: Material(
          color: cardColor,
          elevation: 2,
          shadowColor: Colors.black26,
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.036),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: screenWidth * 0.146,
                          height: screenWidth * 0.146,
                          decoration: const BoxDecoration(
                            color: cardChipBg,
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: (profileImage != null)
                                ? Image.file(
                                    File(profileImage!),
                                    fit: BoxFit.cover,
                                    cacheWidth: 300,
                                  )
                                : Icon(
                                    Icons.person,
                                    size: screenWidth * 0.122,
                                    color: appPrimaryColor,
                                  ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.036),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                cardField('이름', name, screenWidth),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: cardField('역할', role, screenWidth),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: onCallButtonPressed,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        fixedSize: Size(screenWidth * 0.215, 44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.03,
                          ),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: appPrimaryColor,
                      ),
                      child: Text(
                        '문의하기',
                        style: TextStyle(
                          fontSize: screenWidth * 0.038,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
