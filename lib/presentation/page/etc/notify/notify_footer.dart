import 'package:flutter/material.dart';

class NotifyFooter extends StatelessWidget {
  final VoidCallback onReadAndDeleteButtonPressed;
  const NotifyFooter({super.key, required this.onReadAndDeleteButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 10.0,
        right: 16.0,
        bottom: 20.0,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 0.0),
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          fixedSize: Size(MediaQuery.of(context).size.width, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(15.0),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        onPressed: onReadAndDeleteButtonPressed,
        child: const Text(
          '읽음으로 처리',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
