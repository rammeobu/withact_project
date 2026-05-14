import 'dart:io';

import 'package:flutter/material.dart';

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
    final double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.201,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20.0),
          ),
          color: const Color(0xFFFDFDFD),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 20.0),
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFFECEEFD),
                      shape: BoxShape.circle,
                    ),
                    child: (profileImage != null)
                        ? Image.file(File(profileImage!), fit: BoxFit.cover)
                        : const Icon(
                            Icons.person,
                            size: 65,
                            color: Color(0xFF5764F0),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Table(
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
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 3.0,
                                  right: 3.0,
                                  top: screenHeight * 0.001,
                                  bottom: screenHeight * 0.001,
                                ),
                                child: const Center(child: Text('이름')),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 8.0,
                                  top: screenHeight * 0.001,
                                  right: 3.0,
                                  bottom: screenHeight * 0.001,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(profileContent[0]),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 3.0,
                                  right: 3.0,
                                  top: screenHeight * 0.001,
                                  bottom: screenHeight * 0.001,
                                ),
                                child: const Center(child: Text('기술')),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 8.0,
                                  top: screenHeight * 0.001,
                                  right: 3.0,
                                  bottom: screenHeight * 0.001,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(profileContent[1]),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 3.0,
                                  right: 3.0,
                                  top: screenHeight * 0.001,
                                  bottom: screenHeight * 0.001,
                                ),
                                child: const Center(child: Text('소속')),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 8.0,
                                  top: screenHeight * 0.001,
                                  right: 3.0,
                                  bottom: screenHeight * 0.001,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(profileContent[2]),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 3.0,
                                  right: 3.0,
                                  top: screenHeight * 0.001,
                                  bottom: screenHeight * 0.001,
                                ),
                                child: const Center(child: Text('전공')),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 8.0,
                                  top: screenHeight * 0.001,
                                  right: 3.0,
                                  bottom: screenHeight * 0.001,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(profileContent[3]),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: onProfileEditButtonPressed,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B880),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50.0, 0.0),
                          fixedSize: Size(100.0, screenHeight * 0.03),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: const Text(
                          '프로필 수정',
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
}
