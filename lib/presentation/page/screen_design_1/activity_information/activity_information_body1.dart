import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

class ActivityInformationBody1 extends StatelessWidget {
  final String activityOverview;
  final String? poster;
  final ScrollController scrollController;
  const ActivityInformationBody1({
    super.key,
    required this.activityOverview,
    required this.scrollController,
    this.poster,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        cardThumb(poster, screenWidth, screenWidth * 0.22),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.04),
            child: Text(
              activityOverview,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: screenWidth * 0.052,
                fontWeight: FontWeight.w800,
                color: cardInk,
                height: 1.25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
