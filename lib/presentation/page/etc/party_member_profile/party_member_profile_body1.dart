import 'dart:io';

import 'package:flutter/material.dart';

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
    final double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.19,
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.015),
        child: Card(
          color: const Color(0xFFFDFDFD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: const BoxDecoration(
                              color: Color(0xFFECEEFD),
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: (profileImage != null)
                                  ? Image.file(
                                      File(profileImage!),
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Color(0xFF5764F0),
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Table(
                            border: TableBorder.all(
                              color: Colors.grey,
                              width: 0.5,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            columnWidths: const {
                              0: FixedColumnWidth(40),
                              1: FixedColumnWidth(230),
                            },
                            children: [
                              _tableRowBuilder('이름', name, screenHeight),
                              _tableRowBuilder('역할', role, screenHeight),
                            ],
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
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      onPressed: onCallButtonPressed,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        fixedSize: const Size(80, 35),
                        side: const BorderSide(width: 0.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10.0),
                        ),
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        '문의하기',
                        style: TextStyle(
                          fontSize: 17.0,
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

  TableRow _tableRowBuilder(String key, String value, double screenHeight) {
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
          child: Text(value, style: const TextStyle(fontSize: 14.0)),
        ),
      ],
    );
  }
}
