import 'package:flutter/material.dart';

class NotifyPositionSelect extends StatefulWidget {
  final List<String> position;
  final String currentPosition;
  final ValueChanged<String> onChanged;
  const NotifyPositionSelect({
    super.key,
    required this.position,
    required this.currentPosition,
    required this.onChanged,
  });

  @override
  State<NotifyPositionSelect> createState() => _NotifyPositionSelectState();
}

class _NotifyPositionSelectState extends State<NotifyPositionSelect> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.position.map((pos) {
        bool isCurrentSelectedPosition = widget.currentPosition == pos;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              fixedSize: const Size(70, 35),
              backgroundColor: (isCurrentSelectedPosition == true)
                  ? const Color(0xFF5764F0)
                  : Colors.white,
              foregroundColor: (isCurrentSelectedPosition == true)
                  ? Colors.white
                  : Colors.black,
              side: const BorderSide(width: 0.5, color: Colors.grey),
            ),
            onPressed: () {
              setState(() {
                widget.onChanged(pos);
              });
            },
            child: Text(
              pos,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
