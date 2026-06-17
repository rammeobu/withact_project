import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_item.dart';

class MenuBody4 extends StatelessWidget {
  final VoidCallback recruitingActivityMenuSelect;
  final VoidCallback recruitAnnouncementManagementMenuSelect;
  const MenuBody4({
    super.key,
    required this.recruitingActivityMenuSelect,
    required this.recruitAnnouncementManagementMenuSelect,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: 59,
          width: screenWidth,
          color: const Color(0xFFE6E6E6),
          padding: EdgeInsets.only(
            left: screenWidth * 0.049,
            right: screenWidth * 0.036,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            '모집',
            style: TextStyle(
              fontSize: screenWidth * 0.051,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF3F3F3F),
            ),
          ),
        ),
        menuItem('모집중인 활동', screenWidth, recruitingActivityMenuSelect),
        menuItem('모집정보 관리', screenWidth, recruitAnnouncementManagementMenuSelect),
      ],
    );
  }
}
