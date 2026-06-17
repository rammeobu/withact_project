import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

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
        child: Card(
          color: cardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.024),
                          child: Container(
                            width: screenWidth * 0.146,
                            height: screenWidth * 0.146,
                            decoration: const BoxDecoration(
                              color: Color(0xFFECEEFD),
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
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.036,
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
                                infoRow('이름', name, screenWidth),
                                infoRow('역할', role, screenWidth),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.036,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      onPressed: onCallButtonPressed,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        fixedSize: Size(screenWidth * 0.195, 44),
                        side: const BorderSide(width: 0.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(
                            screenWidth * 0.024,
                          ),
                        ),
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        '문의하기',
                        style: TextStyle(
                          fontSize: screenWidth * 0.041,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
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
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: Center(child: Text(label)),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.019,
            top: 1,
            bottom: 1,
          ),
          child: Text(value, style: TextStyle(fontSize: screenWidth * 0.034)),
        ),
      ],
    );
  }
}
