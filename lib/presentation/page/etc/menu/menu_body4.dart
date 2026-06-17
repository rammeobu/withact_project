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
    return menuSection('모집', screenWidth, [
      menuItem(
        '모집중인 활동',
        Icons.campaign_outlined,
        screenWidth,
        recruitingActivityMenuSelect,
      ),
      menuItem(
        '모집정보 관리',
        Icons.edit_note_outlined,
        screenWidth,
        recruitAnnouncementManagementMenuSelect,
      ),
    ]);
  }
}
