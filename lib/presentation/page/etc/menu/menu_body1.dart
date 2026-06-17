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
    return menuSection('정보 관리', screenWidth, [
      menuItem(
        '개인정보 관리',
        Icons.manage_accounts_outlined,
        screenWidth,
        personalInformationManagementMenuSelect,
      ),
      menuItem(
        '프로필/상세정보 관리',
        Icons.badge_outlined,
        screenWidth,
        profileAndDetailManagementMenuSelect,
      ),
    ]);
  }
}
