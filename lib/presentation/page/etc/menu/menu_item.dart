import 'package:flutter/material.dart';

Container menuItem(String label, double screenWidth, VoidCallback onPressed) {
  return Container(
    height: 51,
    width: screenWidth,
    decoration: BoxDecoration(
      border: BoxBorder.all(color: Colors.grey, width: 0.1),
    ),
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        fixedSize: Size(screenWidth, 51),
        shape: const BeveledRectangleBorder(),
        side: BorderSide.none,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: screenWidth * 0.049,
          right: screenWidth * 0.036,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.041),
          ),
        ),
      ),
    ),
  );
}
