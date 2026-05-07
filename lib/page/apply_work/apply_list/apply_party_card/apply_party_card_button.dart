import 'package:flutter/material.dart';

class ApplyPartyCardButton extends StatelessWidget {
  final String applyStatus;
  const ApplyPartyCardButton({super.key, required this.applyStatus});

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
                left: BorderSide(width: 0.5, color: Colors.grey),
                bottom: BorderSide(width: 0.5, color: Colors.grey),
              ),
            ),
            child: Center(
              child: Text(
                applyStatus,
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
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
                left: BorderSide(width: 0.5, color: Colors.grey),
              ),
            ),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: Color(0xff5764f0)),
              child: Text(
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
                left: BorderSide(width: 0.5, color: Colors.grey),
                top: BorderSide(width: 0.5, color: Colors.grey),
              ),
            ),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: Color(0xff5764f0)),
              child: Text(
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
