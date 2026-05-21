import 'package:flutter/material.dart';

class PartyMemberProfileBody3 extends StatelessWidget {
  final String favoriteRole;
  final String favoriteField;
  final String favoriteDomain;

  const PartyMemberProfileBody3({
    super.key,
    required this.favoriteRole,
    required this.favoriteField,
    required this.favoriteDomain,
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
            infoRow('선호 역할', favoriteRole, screenWidth),
            infoRow('선호 분야', favoriteField, screenWidth),
            infoRow('선호 도메인', favoriteDomain, screenWidth),
          ],
        ),
      ],
    );
  }

  TableRow infoRow(String label, String value, double screenWidth) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.019),
          child: Text(label),
        ),
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.019),
          child: Text(value, style: TextStyle(fontSize: screenWidth * 0.034)),
        ),
      ],
    );
  }
}
