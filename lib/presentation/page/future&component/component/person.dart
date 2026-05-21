import 'package:flutter/material.dart';

class Person extends StatelessWidget {
  final double size;
  final VoidCallback? onPressed;
  final bool positionOccupied;
  const Person({
    super.key,
    required this.size,
    this.onPressed,
    this.positionOccupied = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BoxBorder.all(color: Colors.white, width: 0.0),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          padding: EdgeInsets.zero,
          disabledForegroundColor: Colors.grey,
          foregroundColor: positionOccupied
              ? const Color(0xff059568)
              : Colors.grey,
          fixedSize: Size(size, size),
        ),
        icon: Icon(Icons.person, size: size),
      ),
    );
  }
}
