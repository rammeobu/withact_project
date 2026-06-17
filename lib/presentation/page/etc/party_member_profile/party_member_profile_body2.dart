import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import '../../future&component/component/no_scale.dart';
import '../../future&component/card_ui.dart';

class PartyMemberProfileBody2 extends StatelessWidget {
  final String section;
  final String content;
  final ScrollController scrollController;
  const PartyMemberProfileBody2({
    super.key,
    required this.section,
    required this.content,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section,
            style: TextStyle(
              fontSize: screenWidth * 0.041,
              fontWeight: FontWeight.w700,
              color: cardInk,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Material(
              color: cardColor,
              elevation: 2,
              shadowColor: Colors.black26,
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: screenWidth,
                height: 110,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.036),
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: scrollController,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: NoScale(
                        child: Text(
                          content,
                          style: TextStyle(
                            fontSize: screenWidth * 0.036,
                            color: cardInk,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
