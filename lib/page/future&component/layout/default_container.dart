import 'package:flutter/material.dart';


class DefaultContainer extends StatefulWidget {
  Widget child;
  Color? color;
  double? width;
  double? height;
  DefaultContainer({super.key, required this.child, this.width, this.height, this.color});

  @override
  State<DefaultContainer> createState() => _DefaultContainerState();
}

class _DefaultContainerState extends State<DefaultContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: (widget.color != null) ? widget.color : Colors.white,
        border: BoxBorder.all(width: 0.5, color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: widget.child,
    );
  }
}
