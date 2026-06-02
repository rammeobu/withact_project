import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_item.dart';

class MenuBody2 extends StatelessWidget {
  final VoidCallback recentlySearchedWorkMenuSelect;
  final VoidCallback participatingWorkMenuSelect;
  final VoidCallback findWorkMenuSelect;
  const MenuBody2({
    super.key,
    required this.recentlySearchedWorkMenuSelect,
    required this.participatingWorkMenuSelect,
    required this.findWorkMenuSelect,
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
            '활동',
            style: TextStyle(
              fontSize: screenWidth * 0.051,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF3F3F3F),
            ),
          ),
        ),
        menuItem('최근 검색한 활동', screenWidth, recentlySearchedWorkMenuSelect),
        menuItem('참여중인 활동', screenWidth, participatingWorkMenuSelect),
        menuItem('활동 찾기', screenWidth, findWorkMenuSelect),
      ],
    );
  }
}
