import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/activity/activity_card/activity_card_body.dart';
import '../../layout/default_container.dart';

class ActivityCardBasic extends StatelessWidget {
  final String name;
  final String? poster;
  final List<String> timePlace;
  final List<String> position;
  final VoidCallback onTap;

  const ActivityCardBasic({
    super.key,
    required this.name,
    this.poster,
    required this.timePlace,
    required this.position,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 420,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.036),
        child: Card(
          elevation: 3,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(screenWidth * 0.049),
          ),
          color: cardColor,
          child: InkWell(
            onTap: onTap,
            enableFeedback: true,
            splashFactory: InkRipple.splashFactory,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: DefaultContainer(
                        height: 190,
                        width: screenWidth * 0.316,
                        color: posterColor,
                        child: Center(
                          child: (poster != null && poster!.startsWith('http'))
                              ? Image.network(
                                  poster!,
                                  fit: BoxFit.cover,
                                  cacheWidth: 400,
                                )
                              : const Text('포스터'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: screenWidth * 0.036,
                      right: screenWidth * 0.036,
                      bottom: 8,
                    ),
                    child: Center(child: Text(name, style: sectionTitleFont)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.049,
                      right: screenWidth * 0.049,
                      top: 8,
                    ),
                    child: Table(
                      border: TableBorder.all(
                        color: Colors.grey,
                        width: 0.5,
                        borderRadius: BorderRadius.circular(screenWidth * 0.036),
                      ),
                      columnWidths: {
                        0: FixedColumnWidth(screenWidth * 0.097),
                        1: const FlexColumnWidth(),
                      },
                      children: [
                        activityDetailRow('일시', timePlace.isNotEmpty ? timePlace[0] : '', screenWidth),
                        activityDetailRow('장소', timePlace.length > 1 ? timePlace[1] : '', screenWidth),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(child: ActivityCardBody(position: position)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TableRow activityDetailRow(String label, String value, double screenWidth) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.007,
            top: 1,
            right: screenWidth * 0.007,
            bottom: 1,
          ),
          child: Center(child: Text(label, style: tableCellFont)),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.019,
            top: 1,
            right: screenWidth * 0.007,
            bottom: 1,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(value),
          ),
        ),
      ],
    );
  }
}

class ActivityCardApply extends StatelessWidget {
  final String name;
  final String? poster;
  final List<String> timePlace;
  final String applyStatus;
  final VoidCallback? onDetailButtonPressed;
  final VoidCallback? onProfileCheckPressed;
  const ActivityCardApply({
    super.key,
    required this.name,
    this.poster,
    required this.timePlace,
    required this.applyStatus,
    required this.onDetailButtonPressed,
    required this.onProfileCheckPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 420,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.036),
        child: Card(
          elevation: 3,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(screenWidth * 0.049),
          ),
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: DefaultContainer(
                      height: 190,
                      width: screenWidth * 0.316,
                      color: posterColor,
                      child: Center(
                        child: (poster != null && poster!.startsWith('http'))
                            ? Image.network(
                                poster!,
                                fit: BoxFit.cover,
                                cacheWidth: 400,
                              )
                            : const Text('포스터'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.049),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            right: screenWidth * 0.049,
                            bottom: 8,
                          ),
                          child: Center(
                            child: Text(name, style: sectionTitleFont),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: screenWidth * 0.049,
                            top: 8,
                          ),
                          child: Table(
                            border: TableBorder.all(
                              color: Colors.grey,
                              width: 0.5,
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.036,
                              ),
                            ),
                            columnWidths: {
                              0: FixedColumnWidth(screenWidth * 0.097),
                              1: const FlexColumnWidth(),
                            },
                            children: [
                              activityDetailRow('일시', timePlace.isNotEmpty ? timePlace[0] : '', screenWidth),
                              activityDetailRow('장소', timePlace.length > 1 ? timePlace[1] : '', screenWidth),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F3F8),
                            border: BoxBorder.fromLTRB(
                              top: const BorderSide(
                                width: 0.5,
                                color: Colors.grey,
                              ),
                              right: const BorderSide(
                                width: 0.5,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              applyStatus,
                              style: TextStyle(
                                fontSize: screenWidth * 0.034,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: BoxBorder.fromLTRB(
                              top: const BorderSide(
                                width: 0.5,
                                color: Colors.grey,
                              ),
                              right: const BorderSide(
                                width: 0.5,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: appPrimaryColor,
                            ),
                            onPressed: onDetailButtonPressed,
                            child: Text(
                              '활동 설명',
                              style: TextStyle(
                                fontSize: screenWidth * 0.034,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: BoxBorder.fromLTRB(
                              top: const BorderSide(
                                width: 0.5,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: appPrimaryColor,
                            ),
                            onPressed: onProfileCheckPressed,
                            child: Text(
                              '지원서 확인',
                              style: TextStyle(
                                fontSize: screenWidth * 0.034,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow activityDetailRow(String label, String value, double screenWidth) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.007,
            top: 1,
            right: screenWidth * 0.007,
            bottom: 1,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(fontSize: screenWidth * 0.032),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.019,
            top: 1,
            right: screenWidth * 0.007,
            bottom: 1,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(value),
          ),
        ),
      ],
    );
  }
}
