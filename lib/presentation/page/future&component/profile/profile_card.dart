import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

class ProfileCardBasic extends StatelessWidget {
  final List<String> profileContent;
  final String? profileImage;
  final VoidCallback onProfileEditButtonPressed;
  const ProfileCardBasic({
    super.key,
    required this.profileContent,
    this.profileImage,
    required this.onProfileEditButtonPressed,
  });

  Widget _field(String label, String value, double screenWidth) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.03,
            fontWeight: FontWeight.w600,
            color: cardSub,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Text(
              value.isEmpty ? '-' : value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: screenWidth * 0.036,
                fontWeight: FontWeight.w600,
                color: cardInk,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final String name = profileContent.isNotEmpty ? profileContent[0] : '';
    final String skill = profileContent.length > 1 ? profileContent[1] : '';
    final String belong = profileContent.length > 2 ? profileContent[2] : '';
    final String major = profileContent.length > 3 ? profileContent[3] : '';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.036, vertical: 6),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(child: _field('이름', name, screenWidth)),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: _field('기술', skill, screenWidth),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(child: _field('소속', belong, screenWidth)),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: _field('전공', major, screenWidth),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: onProfileEditButtonPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: appPrimaryColor,
                  side: const BorderSide(color: appPrimaryColor, width: 1),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                  minimumSize: const Size(0, 36),
                  shape: const StadiumBorder(),
                ),
                child: Text(
                  '수정',
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
