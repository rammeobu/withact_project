import 'package:flutter/material.dart';

class ApplicantSelectPosition extends StatefulWidget {
  final List<String> position;
  final String currentPosition;
  final ValueChanged<String> onChanged;
  const ApplicantSelectPosition({
    super.key,
    required this.position,
    required this.currentPosition,
    required this.onChanged,
  });

  @override
  State<ApplicantSelectPosition> createState() =>
      _ApplicantSelectPositionState();
}

class _ApplicantSelectPositionState extends State<ApplicantSelectPosition> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7.0),
      child: Row(
        children: widget.position.map((pos) {
          bool isCurrentSelectedPosition = widget.currentPosition == pos;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 10.0,
            ),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                fixedSize: const Size(70, 45),
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
      ),
    );
  }
}
