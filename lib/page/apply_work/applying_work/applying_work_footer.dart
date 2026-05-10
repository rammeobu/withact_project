import 'package:flutter/material.dart';

class ApplyingWorkFooter extends StatelessWidget {
  final VoidCallback? onApplyCancelButtonPressed;
  final VoidCallback? onApplyListButtonPressed;
  const ApplyingWorkFooter({
    super.key,
    this.onApplyCancelButtonPressed,
    this.onApplyListButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 10.0,
        right: 16.0,
        bottom: 20.0,
      ),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: onApplyCancelButtonPressed,
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFFF34343),
              fixedSize: const Size(165, 55),
              padding: EdgeInsets.zero,
              side: const BorderSide(width: 0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              '지원 취소',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          OutlinedButton(
            onPressed: onApplyListButtonPressed,
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              fixedSize: const Size(165, 55),
              padding: EdgeInsets.zero,
              side: const BorderSide(width: 0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              '지원 목록',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
