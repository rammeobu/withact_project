import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

class ProfileCardEdit extends StatelessWidget {
  final List<TextEditingController> controllers;
  final String? profileImage;
  final VoidCallback onProfileImageTap;
  final bool anonymousFlag;
  final Function(bool?) onAnonymousChanged;
  final VoidCallback onProfileSaveButtonPressed;

  const ProfileCardEdit({
    super.key,
    required this.controllers,
    required this.onProfileImageTap,
    required this.anonymousFlag,
    required this.onAnonymousChanged,
    required this.onProfileSaveButtonPressed,
    this.profileImage,
  });

  Widget _editField(String label, TextEditingController controller, double screenWidth) {
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
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(bottom: 4),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE0E3E8)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: appPrimaryColor),
                ),
              ),
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
    return Material(
      color: cardColor,
      elevation: 2,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(screenWidth * 0.05),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.045),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onProfileImageTap,
                  child: Container(
                    width: screenWidth * 0.17,
                    height: screenWidth * 0.17,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: cardChipBg,
                      shape: BoxShape.circle,
                    ),
                    child: (profileImage != null)
                        ? Image.file(File(profileImage!), fit: BoxFit.cover, cacheWidth: 300)
                        : Icon(
                            Icons.camera_alt_outlined,
                            size: screenWidth * 0.07,
                            color: appPrimaryColor,
                          ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.04),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(child: _editField('이름', controllers[0], screenWidth)),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: _editField('기술', controllers[1], screenWidth),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Row(
                            children: [
                              Expanded(child: _editField('소속', controllers[2], screenWidth)),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: _editField('전공', controllers[3], screenWidth),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: anonymousFlag,
                        onChanged: onAnonymousChanged,
                        activeColor: appPrimaryColor,
                        visualDensity: VisualDensity.compact,
                      ),
                      GestureDetector(
                        onTap: () => onAnonymousChanged(!anonymousFlag),
                        child: Text(
                          '익명 사용',
                          style: TextStyle(fontSize: screenWidth * 0.034),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: onProfileSaveButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appPrimaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      minimumSize: const Size(0, 40),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      '프로필 저장',
                      style: TextStyle(
                        fontSize: screenWidth * 0.034,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
