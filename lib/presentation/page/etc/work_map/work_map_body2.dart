import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/etc/work_map/work_map_work_card.dart';

class WorkMapBody2 extends StatelessWidget {
  final List<dynamic>? workList;
  final void Function(String) onDetailButtonPressed;
  final void Function(String) onPartyFindButtonPressed;
  final ScrollController workCardScrollController;
  const WorkMapBody2({
    super.key,
    required this.workCardScrollController,
    this.workList,
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
          controller: workCardScrollController,
          scrollDirection: Axis.horizontal,
          child: (workList != null)
              ? Row(
                  children: workList!
                      .map<Widget>(
                        (work) => RepaintBoundary(
                          child: SizedBox(
                            width: screenWidth * 0.9,
                            child: WorkMapWorkCard(
                              name: work[0],
                              timePlace: work[1],
                              poster: (work.length > 4) ? work[2] : null,
                              onDetailButtonPressed: () =>
                                  onDetailButtonPressed(work.id),
                              onPartyFindButtonPressed: () =>
                                  onPartyFindButtonPressed(work.id),
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
