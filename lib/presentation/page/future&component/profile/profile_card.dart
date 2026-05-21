import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

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

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 175,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.036),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(screenWidth * 0.049),
          ),
          color: cardColor,
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.024,
                    bottom: 23,
                  ),
                  child: Container(
                    width: screenWidth * 0.195,
                    height: screenWidth * 0.195,
                    decoration: const BoxDecoration(
                      color: Color(0xFFECEEFD),
                      shape: BoxShape.circle,
                    ),
                    child: (profileImage != null)
                        ? Image.file(File(profileImage!), fit: BoxFit.cover)
                        : Icon(
                            Icons.person,
                            size: screenWidth * 0.158,
                            color: appPrimaryColor,
                          ),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.036, top: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Table(
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
                          infoRow('이름', profileContent[0], screenWidth),
                          infoRow('기술', profileContent[1], screenWidth),
                          infoRow('소속', profileContent[2], screenWidth),
                          infoRow('전공', profileContent[3], screenWidth),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: onProfileEditButtonPressed,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B880),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.zero,
                          minimumSize: Size(screenWidth * 0.122, 0),
                          fixedSize: Size(screenWidth * 0.243, 42),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              screenWidth * 0.036,
                            ),
                          ),
                        ),
                        child: Text(
                          '프로필 수정',
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

  TableRow infoRow(String label, String value, double screenWidth) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.007,
            vertical: 1,
          ),
          child: Center(child: Text(label)),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.019,
            top: 1,
            right: screenWidth * 0.007,
            bottom: 1,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(value),
          ),
        ),
      ],
    );
  }
}
