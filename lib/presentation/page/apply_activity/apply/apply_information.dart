import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

class ApplyInformation extends StatelessWidget {
  final String activityOverview;
  final String? poster;
  final ScrollController scrollController;
  const ApplyInformation({
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
        cardThumb(poster, screenWidth, 116),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.024),
            child: Material(
              color: cardColor,
              elevation: 2,
              shadowColor: Colors.black26,
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                height: 116,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.032),
                  child: Scrollbar(
                    controller: scrollController,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          activityOverview,
                          style: TextStyle(
                            fontSize: screenWidth * 0.041,
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
