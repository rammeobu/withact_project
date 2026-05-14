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
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Table(
          border: TableBorder.all(
            color: Colors.grey,
            width: 0.5,
            borderRadius: BorderRadius.circular(15),
          ),
          columnWidths: const {0: FixedColumnWidth(100), 1: FlexColumnWidth()},
          children: [
            _tableRowBuilder('선호 역할', controllers[0], screenHeight),
            _tableRowBuilder('선호 분야', controllers[1], screenHeight),
            _tableRowBuilder('선호 도메인', controllers[2], screenHeight),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton(
            onPressed: onDetailSaveButtonPressed,
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFF10B880),
              foregroundColor: Colors.white,
              fixedSize: Size(130.0, screenHeight * 0.04),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text('상세정보 저장', style: TextStyle(fontSize: 14.0)),
          ),
        ),
      ],
    );
  }

  TableRow _tableRowBuilder(
    String key,
    TextEditingController controller,
    double screenHeight,
  ) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.only(left: 8.0), child: Text(key)),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: const TextStyle(fontSize: 14.0),
          ),
        ),
      ],
    );
  }
}
