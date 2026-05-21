import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_item.dart';

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
            '정보 관리',
            style: TextStyle(
              fontSize: screenWidth * 0.051,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF3F3F3F),
            ),
          ),
        ),
        menuItem('개인정보 관리', screenWidth, personalInformationManagementMenuSelect),
        menuItem('프로필/상세정보 관리', screenWidth, profileAndDetailManagementMenuSelect),
      ],
    );
  }
}
