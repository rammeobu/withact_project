import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/etc/activity_map/activity_map_activity_card.dart';

class ActivityMapBody2 extends StatelessWidget {
  final List<dynamic>? activityList;
  final void Function(String) onDetailButtonPressed;
  final void Function(String) onPartyFindButtonPressed;
  final ScrollController activityCardScrollController;
  const ActivityMapBody2({
    super.key,
    required this.activityCardScrollController,
    this.activityList,
    required this.onDetailButtonPressed,
    required this.onPartyFindButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Text(
            '해당 지역에서의 활동',
            style: TextStyle(
              fontSize: screenWidth * 0.051,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SingleChildScrollView(
          controller: activityCardScrollController,
          scrollDirection: Axis.horizontal,
          child: (activityList != null)
              ? Row(
                  children: activityList!
                      .map<Widget>(
                        (activity) => RepaintBoundary(
                          child: SizedBox(
                            width: screenWidth * 0.9,
                            child: ActivityMapActivityCard(
                              name: activity[0],
                              timePlace: activity[1],
                              poster: (activity.length > 4) ? activity[2] : null,
                              onDetailButtonPressed: () =>
                                  onDetailButtonPressed(activity.id),
                              onPartyFindButtonPressed: () =>
                                  onPartyFindButtonPressed(activity.id),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              : SizedBox(
                  width: screenWidth * 0.9,
                  height: 169,
                  child: const Center(child: Text('해당 지역에서의 활동이 없습니다.')),
                ),
        ),
      ],
    );
  }
}
