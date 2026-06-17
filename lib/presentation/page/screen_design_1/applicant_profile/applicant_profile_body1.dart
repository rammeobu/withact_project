import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';
import '../../future&component/component/no_scale.dart';

class ApplicantProfileBody1 extends StatelessWidget {
  final String section;
  final String content;
  final ScrollController scrollController;
  const ApplicantProfileBody1({
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
              fontWeight: FontWeight.w600,
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
                width: double.infinity,
                height: 110,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.032),
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
