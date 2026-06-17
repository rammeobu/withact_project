import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

class ProfileCardApplicant extends StatelessWidget {
  final List<String> profileContent;
  final String? profileImage;
  final VoidCallback onTap;
  const ProfileCardApplicant({
    super.key,
    required this.profileContent,
    required this.onTap,
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final String name = profileContent.isNotEmpty ? profileContent[0] : '';
    final String role = profileContent.length > 1 ? profileContent[1] : '';
    final String skill = profileContent.length > 2 ? profileContent[2] : '';
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Material(
        color: cardColor,
        elevation: 2,
        shadowColor: Colors.black26,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.16,
                  height: screenWidth * 0.16,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: cardChipBg,
                    shape: BoxShape.circle,
                  ),
                  child: (profileImage != null)
                      ? Image.file(File(profileImage!), fit: BoxFit.cover, cacheWidth: 300)
                      : Icon(
                          Icons.person,
                          size: screenWidth * 0.095,
                          color: appPrimaryColor,
                        ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                name.isEmpty ? '-' : name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.046,
                                  fontWeight: FontWeight.w800,
                                  color: cardInk,
                                ),
                              ),
                            ),
                            if (role.isNotEmpty)
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
                                  role,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    fontWeight: FontWeight.w700,
                                    color: appPrimaryColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (skill.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: cardInfoRow(
                              Icons.workspace_premium_outlined,
                              skill,
                              screenWidth,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Icon(
                    Icons.chevron_right,
                    size: screenWidth * 0.05,
                    color: cardPosterIcon,
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
