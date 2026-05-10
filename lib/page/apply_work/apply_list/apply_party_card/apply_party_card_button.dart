import 'package:flutter/material.dart';

class ApplyPartyCardButton extends StatelessWidget {
  final String applyStatus;
  final VoidCallback onDetailButtonPressed;
  final VoidCallback onCheckProfileButtonPressed;
  const ApplyPartyCardButton({
    super.key,
    required this.applyStatus,
    required this.onDetailButtonPressed,
    required this.onCheckProfileButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              border: BoxBorder.fromLTRB(
                left: const BorderSide(width: 0.5, color: Colors.grey),
                bottom: const BorderSide(width: 0.5, color: Colors.grey),
              ),
            ),
            child: Center(
              child: Text(
                applyStatus,
                style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              border: BoxBorder.fromLTRB(
                left: const BorderSide(width: 0.5, color: Colors.grey),
              ),
            ),
            child: TextButton(
              onPressed: onDetailButtonPressed,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xff5764f0),
              ),
              child: const Text(
                '활동 설명',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              border: BoxBorder.fromLTRB(
                left: const BorderSide(width: 0.5, color: Colors.grey),
                top: const BorderSide(width: 0.5, color: Colors.grey),
              ),
            ),
            child: TextButton(
              onPressed: onCheckProfileButtonPressed,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xff5764f0),
              ),
              child: const Text(
                '지원자 확인',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
