import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_item.dart';

class MenuBody2 extends StatelessWidget {
  final VoidCallback recentlySearchedActivityMenuSelect;
  final VoidCallback participatingActivityMenuSelect;
  final VoidCallback findActivityMenuSelect;
  final VoidCallback findPartyMenuSelect;
  const MenuBody2({
    super.key,
    required this.recentlySearchedActivityMenuSelect,
    required this.participatingActivityMenuSelect,
    required this.findActivityMenuSelect,
    required this.findPartyMenuSelect,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return menuSection('활동', screenWidth, [
      menuItem(
        '최근 검색한 활동',
        Icons.history,
        screenWidth,
        recentlySearchedActivityMenuSelect,
      ),
      menuItem(
        '참여중인 활동',
        Icons.groups_outlined,
        screenWidth,
        participatingActivityMenuSelect,
      ),
      menuItem(
        '활동 찾기',
        Icons.search,
        screenWidth,
        findActivityMenuSelect,
      ),
      menuItem(
        '파티 찾기',
        Icons.person_search_outlined,
        screenWidth,
        findPartyMenuSelect,
      ),
    ]);
  }
}
