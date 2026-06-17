import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import '../../future&component/card_ui.dart';

class ParticipatingPartyBody1 extends StatelessWidget {
  final String activityOverview;
  final String? poster;
  final ScrollController scrollController;
  const ParticipatingPartyBody1({
    super.key,
    required this.activityOverview,
    required this.scrollController,
    this.poster,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: cardThumb(poster, screenWidth, screenWidth * 0.195),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.024),
            child: Material(
              color: cardChipBg,
              elevation: 2,
              shadowColor: Colors.black26,
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: screenWidth,
                height: screenWidth * 0.195,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Scrollbar(
                    controller: scrollController,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          activityOverview,
                          style: TextStyle(
                            fontSize: screenWidth * 0.039,
                            color: appPrimaryColor,
                            fontWeight: FontWeight.w700,
                          ),
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
    );
  }
}
