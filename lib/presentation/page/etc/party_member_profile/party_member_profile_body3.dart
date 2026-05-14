import 'package:flutter/material.dart';

class PartyMemberProfileBody3 extends StatelessWidget {
  final String preferenceRole;
  final String preferenceField;
  final String preferenceDomain;

  const PartyMemberProfileBody3({
    super.key,
    required this.preferenceRole,
    required this.preferenceField,
    required this.preferenceDomain,
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
            _tableRowBuilder('선호 역할', preferenceRole, screenHeight),
            _tableRowBuilder('선호 분야', preferenceField, screenHeight),
            _tableRowBuilder('선호 도메인', preferenceDomain, screenHeight),
          ],
        ),
      ],
    );
  }

  TableRow _tableRowBuilder(String key, String value, double screenHeight) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.only(left: 8.0), child: Text(key)),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(value, style: const TextStyle(fontSize: 14.0)),
        ),
      ],
    );
  }
}
