import 'dart:io';

import 'package:flutter/material.dart';

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
    final double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.21,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: const Color(0xFFFDFDFD),
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.008),
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: GestureDetector(
                          onTap: onProfileImageTap,
                          child: Container(
                            width: 80.0,
                            height: 80.0,
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
                                : const Icon(
                                    Icons.person,
                                    size: 65,
                                    color: Color(0xFF5764F0),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 15.0,
                          top: screenHeight * 0.007,
                        ),
                        child: Table(
                          border: TableBorder.all(
                            color: Colors.grey,
                            width: 0.5,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          columnWidths: const {
                            0: FixedColumnWidth(40),
                            1: FlexColumnWidth(),
                          },
                          children: [
                            _tableRowBuilder(
                              '이름',
                              controllers[0],
                              screenHeight,
                            ),
                            _tableRowBuilder(
                              '기술',
                              controllers[1],
                              screenHeight,
                            ),
                            _tableRowBuilder(
                              '소속',
                              controllers[2],
                              screenHeight,
                            ),
                            _tableRowBuilder(
                              '전공',
                              controllers[3],
                              screenHeight,
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
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                          fixedSize: Size(118.0, screenHeight * 0.04),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: const Text(
                          '프로필 저장',
                          style: TextStyle(fontSize: 14.0),
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

  TableRow _tableRowBuilder(
    String key,
    TextEditingController controller,
    double screenHeight,
  ) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.001),
          child: Center(child: Text(key)),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            top: screenHeight * 0.001,
            bottom: screenHeight * 0.001,
          ),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: const TextStyle(fontSize: 14.0),
          ),
        ),
      ],
    );
  }
}
