import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
            border: Border.all(color: const Color(0xFFE0E3E8)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: 4,
          ),
          child: Table(
            columnWidths: {
              0: FixedColumnWidth(screenWidth * 0.243),
              1: const FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              editRow('선호 역할', controllers[0], screenWidth),
              editRow('선호 분야', controllers[1], screenWidth),
              editRow('선호 도메인', controllers[2], screenWidth),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: onDetailSaveButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: appPrimaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                minimumSize: const Size(0, 44),
                shape: const StadiumBorder(),
              ),
              child: Text(
                '상세정보 저장',
                maxLines: 1,
                style: TextStyle(
                  fontSize: screenWidth * 0.034,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.034,
              fontWeight: FontWeight.w600,
              color: cardSub,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(bottom: 4),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE0E3E8)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: appPrimaryColor),
              ),
            ),
            style: TextStyle(
              fontSize: screenWidth * 0.034,
              fontWeight: FontWeight.w600,
              color: cardInk,
            ),
          ),
        ),
      ],
    );
  }
}
