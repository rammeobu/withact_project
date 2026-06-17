import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

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
    return Material(
      color: cardColor,
      elevation: 2,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(screenWidth * 0.05),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenWidth * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardField('선호 역할', favoriteRole, screenWidth),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: cardField('선호 분야', favoriteField, screenWidth),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: cardField('선호 도메인', favoriteDomain, screenWidth),
            ),
          ],
        ),
      ),
    );
  }
}
