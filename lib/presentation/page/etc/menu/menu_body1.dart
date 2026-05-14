import 'package:flutter/material.dart';

class MenuBody1 extends StatelessWidget {
  final VoidCallback personalInformationManagementMenuSelect;
  final VoidCallback profileAndDetailManagementMenuSelect;
  const MenuBody1({
    super.key,
    required this.personalInformationManagementMenuSelect,
    required this.profileAndDetailManagementMenuSelect,
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
                '정보 관리',
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
          '개인정보 관리',
          screenHeight * 0.06,
          screenWidth,
          personalInformationManagementMenuSelect,
        ),
        _containerBuilder(
          '프로필/상세정보 관리',
          screenHeight * 0.06,
          screenWidth,
          profileAndDetailManagementMenuSelect,
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
