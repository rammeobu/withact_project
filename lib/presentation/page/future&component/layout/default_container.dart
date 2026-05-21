import 'package:flutter/material.dart';

class DefaultContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double? width;
  final double? height;
  const DefaultContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        border: BoxBorder.all(width: 0.5, color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }
}
