import 'dart:io';

import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: 17),
      child: SizedBox(
        width: double.infinity,
        height: 114,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(screenWidth * 0.049),
          ),
          color: const Color(0xFFECEEFD),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.024),
                  child: Container(
                    width: 93,
                    height: 89,
                    decoration: const BoxDecoration(
                      color: Color(0xFFECEEFD),
                      shape: BoxShape.circle,
                    ),
                    child: (profileImage != null)
                        ? Image.file(File(profileImage!))
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
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.024,
                    right: screenWidth * 0.024,
                    bottom: 4,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '파티장',
                            style: TextStyle(
                              fontSize: screenWidth * 0.039,
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: EdgeInsets.zero,
                              side: const BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(
                                  screenWidth * 0.024,
                                ),
                              ),
                              fixedSize: Size(screenWidth * 0.195, 26),
                              minimumSize: const Size(0, 0),
                            ),
                            onPressed: onCallButtonPressed,
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
          child: Center(
            child: Text(label, style: TextStyle(fontSize: screenWidth * 0.029)),
          ),
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
            child: Text(value, style: TextStyle(fontSize: screenWidth * 0.029)),
          ),
        ),
      ],
    );
  }
}
