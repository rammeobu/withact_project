import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/etc/menu/menu_item.dart';

class MenuBody3 extends StatelessWidget {
  final VoidCallback applyingActivityMenuSelect;
  const MenuBody3({super.key, required this.applyingActivityMenuSelect});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return menuSection('지원', screenWidth, [
      menuItem(
        '지원중인 활동',
        Icons.assignment_outlined,
        screenWidth,
        applyingActivityMenuSelect,
      ),
    ]);
  }
}
