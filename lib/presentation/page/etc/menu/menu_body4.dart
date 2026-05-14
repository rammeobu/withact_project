import 'package:flutter/material.dart';

class MenuBody4 extends StatelessWidget {
  final VoidCallback recruitingWorkMenuSelect;
  final VoidCallback recruitAnnouncementManagementMenuSelect;
  const MenuBody4({
    super.key,
    required this.recruitingWorkMenuSelect,
    required this.recruitAnnouncementManagementMenuSelect,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: screenHeight * 0.07,
          width: screenWidth,
          color: Color(0xFFE6E6E6),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                '모집',
                style: TextStyle(
                  fontSize: 21.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3F3F3F),
                ),
              ),
            ),
          ),
        ),
        _containerBuilder(
          '모집중인 활동',
          screenHeight * 0.06,
          screenWidth,
          recruitingWorkMenuSelect,
        ),
        _containerBuilder(
          '모집정보 관리',
          screenHeight * 0.06,
          screenWidth,
          recruitAnnouncementManagementMenuSelect,
        ),
      ],
    );
  }

  Container _containerBuilder(
    String value,
    double height,
    double width,
    VoidCallback onPressed,
  ) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: BoxBorder.all(color: Colors.grey, width: 0.1),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          fixedSize: Size(width, height),
          shape: const BeveledRectangleBorder(),
          side: BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 15.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: const TextStyle(color: Colors.grey, fontSize: 17.0),
            ),
          ),
        ),
      ),
    );
  }
}
