import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(screenWidth * 0.049),
          ),
          color: const Color(0xfff0f3f6),
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.024),
                    child: Container(
                      width: screenWidth * 0.195,
                      height: screenWidth * 0.195,
                      decoration: const BoxDecoration(
                        color: cardColor,
                        shape: BoxShape.circle,
                      ),
                      child: profileImage != null
                          ? Image.file(File(profileImage!))
                          : Icon(
                              Icons.person,
                              size: screenWidth * 0.158,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.024,
                      right: screenWidth * 0.024,
                    ),
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
                            infoRow('역할', profileContent[1], screenWidth),
                            infoRow('기술', profileContent[2], screenWidth),
                          ],
                        ),
                      ],
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

  TableRow infoRow(String label, String value, double screenWidth) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.007),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: screenWidth * 0.032,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.019,
            top: screenWidth * 0.007,
            right: screenWidth * 0.007,
            bottom: screenWidth * 0.007,
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
