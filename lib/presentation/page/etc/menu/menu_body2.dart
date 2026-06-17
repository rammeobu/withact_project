import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_item.dart';

class MenuBody2 extends StatelessWidget {
  final VoidCallback recentlySearchedActivityMenuSelect;
  final VoidCallback participatingActivityMenuSelect;
  final VoidCallback findActivityMenuSelect;
  const MenuBody2({
    super.key,
    required this.recentlySearchedActivityMenuSelect,
    required this.participatingActivityMenuSelect,
    required this.findActivityMenuSelect,
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
        menuItem('최근 검색한 활동', screenWidth, recentlySearchedActivityMenuSelect),
        menuItem('참여중인 활동', screenWidth, participatingActivityMenuSelect),
        menuItem('활동 찾기', screenWidth, findActivityMenuSelect),
      ],
    );
  }
}
