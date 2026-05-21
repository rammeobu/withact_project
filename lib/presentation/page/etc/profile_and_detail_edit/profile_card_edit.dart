import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

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

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 250,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.049),
        ),
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.024),
                        child: GestureDetector(
                          onTap: onProfileImageTap,
                          child: Container(
                            width: screenWidth * 0.195,
                            height: screenWidth * 0.195,
                            decoration: const BoxDecoration(
                              color: Color(0xFFECEEFD),
                              shape: BoxShape.circle,
                            ),
                            child: (profileImage != null)
                                ? ClipOval(
                                    child: Image.file(
                                      File(profileImage!),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    size: screenWidth * 0.158,
                                    color: appPrimaryColor,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.036,
                          top: 6,
                        ),
                        child: Table(
                          border: TableBorder.all(
                            color: Colors.grey,
                            width: 0.5,
                            borderRadius: BorderRadius.circular(
                              screenWidth * 0.036,
                            ),
                          ),
                          columnWidths: {
                            0: FixedColumnWidth(screenWidth * 0.097),
                            1: const FlexColumnWidth(),
                          },
                          children: [
                            editRow(
                              '이름',
                              controllers[0],
                              screenWidth,
                              isRequired: true,
                            ),
                            editRow(
                              '기술',
                              controllers[1],
                              screenWidth,
                              isRequired: true,
                            ),
                            editRow(
                              '소속',
                              controllers[2],
                              screenWidth,
                              isRequired: true,
                            ),
                            editRow(
                              '전공',
                              controllers[3],
                              screenWidth,
                              isRequired: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.036,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: anonymousFlag,
                            onChanged: onAnonymousChanged,
                          ),
                          GestureDetector(
                            onTap: () => onAnonymousChanged(!anonymousFlag),
                            child: const Text('익명 사용'),
                          ),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: onProfileSaveButtonPressed,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B880),
                          foregroundColor: Colors.white,
                          fixedSize: Size(screenWidth * 0.287, 34),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              screenWidth * 0.036,
                            ),
                          ),
                        ),
                        child: Text(
                          '프로필 저장',
                          style: TextStyle(fontSize: screenWidth * 0.034),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow editRow(
    String label,
    TextEditingController controller,
    double screenWidth, {
    bool isRequired = false,
  }) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label),
                if (isRequired)
                  const Text('*', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.019,
            top: 7,
            bottom: 7,
          ),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: TextStyle(fontSize: screenWidth * 0.034),
          ),
        ),
      ],
    );
  }
}
