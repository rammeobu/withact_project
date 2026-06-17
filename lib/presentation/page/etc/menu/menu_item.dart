import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

Widget menuItem(
  String label,
  IconData icon,
  double screenWidth,
  VoidCallback onPressed,
) {
  return Material(
    color: Colors.white,
    child: InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.045,
          vertical: 16,
        ),
        child: Row(
          children: [
            Icon(icon, size: screenWidth * 0.055, color: appPrimaryColor),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.04),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF20232A),
                  ),
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: screenWidth * 0.05,
              color: const Color(0xFFB7BDC6),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget menuSection(String title, double screenWidth, List<Widget> items) {
  final List<Widget> children = [];
  for (int i = 0; i < items.length; i++) {
    children.add(items[i]);
    if (i < items.length - 1) {
      children.add(
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.14),
          child: Container(height: 1, color: const Color(0xFFF0F1F3)),
        ),
      );
    }
  }
  return Padding(
    padding: EdgeInsets.fromLTRB(screenWidth * 0.036, 18, screenWidth * 0.036, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.012, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.034,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF8A8F98),
            ),
          ),
        ),
        Material(
          color: Colors.white,
          elevation: 1,
          shadowColor: Colors.black12,
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          clipBehavior: Clip.antiAlias,
          child: Column(children: children),
        ),
      ],
    ),
  );
}
