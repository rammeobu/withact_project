import 'package:flutter/material.dart';

class Person extends StatefulWidget {
  double size;
  final VoidCallback? onPressed;
  Person({super.key, required this.size, this.onPressed});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BoxBorder.all(color: Colors.white,width:0.0),
        shape: BoxShape.circle,
      ),
      child: IconButton(onPressed: widget.onPressed, style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        disabledForegroundColor: Colors.grey,
        foregroundColor: Color(0xff059568),
        fixedSize: Size(widget.size+10,widget.size+10),
      ),icon: Icon(Icons.person, size: widget.size)),
    );
  }
}
