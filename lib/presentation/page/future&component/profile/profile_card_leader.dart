import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

class ProfileCardLeader extends StatelessWidget {
  final List<String> profileContent;
  final String? profileImage;
  final VoidCallback onCallButtonPressed;
  const ProfileCardLeader({
    super.key,
    required this.profileContent,
    required this.onCallButtonPressed,
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final String name = profileContent.isNotEmpty ? profileContent[0] : '';
    final String skill = profileContent.length > 1 ? profileContent[1] : '';
    return Padding(
      padding: const EdgeInsets.only(top: 17),
      child: Material(
        color: cardColor,
        elevation: 2,
        shadowColor: Colors.black26,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.045),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.15,
                height: screenWidth * 0.15,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: cardChipBg,
                  shape: BoxShape.circle,
                ),
                child: (profileImage != null)
                    ? Image.file(File(profileImage!), fit: BoxFit.cover, cacheWidth: 300)
                    : Icon(
                        Icons.person,
                        size: screenWidth * 0.09,
                        color: appPrimaryColor,
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: cardChipBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '파티장',
                          style: TextStyle(
                            fontSize: screenWidth * 0.03,
                            fontWeight: FontWeight.w700,
                            color: appPrimaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: cardField('이름', name, screenWidth),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: cardField('기술', skill, screenWidth),
                      ),
                    ],
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: onCallButtonPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: appPrimaryColor,
                  side: const BorderSide(color: appPrimaryColor, width: 1),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                  minimumSize: const Size(0, 36),
                  shape: const StadiumBorder(),
                ),
                child: Text(
                  '문의하기',
                  style: TextStyle(
                    fontSize: screenWidth * 0.032,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
