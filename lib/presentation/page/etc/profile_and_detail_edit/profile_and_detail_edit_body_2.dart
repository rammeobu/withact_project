import 'package:flutter/material.dart';

class ProfileAndDetailEditBody2 extends StatelessWidget {
  final List<TextEditingController> controllers;
  final VoidCallback onDetailSaveButtonPressed;

  const ProfileAndDetailEditBody2({
    super.key,
    required this.controllers,
    required this.onDetailSaveButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Table(
          border: TableBorder.all(
            color: Colors.grey,
            width: 0.5,
            borderRadius: BorderRadius.circular(screenWidth * 0.036),
          ),
          columnWidths: {
            0: FixedColumnWidth(screenWidth * 0.243),
            1: const FlexColumnWidth(),
          },
          children: [
            editRow('선호 역할', controllers[0], screenWidth),
            editRow('선호 분야', controllers[1], screenWidth),
            editRow('선호 도메인', controllers[2], screenWidth),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton(
            onPressed: onDetailSaveButtonPressed,
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFF10B880),
              foregroundColor: Colors.white,
              fixedSize: Size(screenWidth * 0.316, 34),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.024),
              ),
            ),
            child: Text(
              '상세정보 저장',
              style: TextStyle(fontSize: screenWidth * 0.034),
            ),
          ),
        ),
      ],
    );
  }

  TableRow editRow(
    String label,
    TextEditingController controller,
    double screenWidth,
  ) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.019,
            top: 10,
            bottom: 10,
          ),
          child: Text(label),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.019,
            top: 10,
            bottom: 10,
          ),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: TextStyle(fontSize: screenWidth * 0.034),
          ),
        ),
      ],
    );
  }
}
