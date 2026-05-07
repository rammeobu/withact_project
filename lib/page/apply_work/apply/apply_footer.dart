import 'package:flutter/material.dart';

class ApplyFooter extends StatelessWidget {
  final VoidCallback? onTextButtonPressed;
  final VoidCallback? onAcceptButtonPressed;
  final VoidCallback? onRejectButtonPressed;
  const ApplyFooter({
    super.key,
    this.onTextButtonPressed,
    this.onAcceptButtonPressed,
    this.onRejectButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        top: 10.0,
        right: 16.0,
        bottom: 20.0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              OutlinedButton(
                onPressed: onAcceptButtonPressed,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xFF1AB97A),
                  fixedSize: Size(165, 65),
                  padding: EdgeInsets.zero,
                  side: BorderSide(width: 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  '수락',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              OutlinedButton(
                onPressed: onAcceptButtonPressed,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Color(0xFFF34343),
                  fixedSize: Size(165, 65),
                  padding: EdgeInsets.zero,
                  side: BorderSide(width: 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  '거절',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          TextButton(
            onPressed: onTextButtonPressed,
            child: Text(
              '지원자 목록으로 돌아가기',
              style: TextStyle(
                color: Color(0xFF5764F0),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
