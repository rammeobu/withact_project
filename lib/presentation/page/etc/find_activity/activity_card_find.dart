import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

import '../../future&component/layout/default_container.dart'
    show DefaultContainer;

class ActivityCardFind extends StatelessWidget {
  final String activityName;
  final String? poster;
  final List<String> timePlace;
  final VoidCallback? onActivityInformationButtonPressed;
  final VoidCallback? onFindPartyButtonPressed;
  final bool selectMode;
  final VoidCallback? onActivitySelected;
  const ActivityCardFind({
    super.key,
    required this.activityName,
    this.poster,
    required this.timePlace,
    required this.onActivityInformationButtonPressed,
    required this.onFindPartyButtonPressed,
    this.selectMode = false,
    this.onActivitySelected,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(screenWidth * 0.049),
      ),
      color: cardColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.029,
              top: 10,
              bottom: 10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DefaultContainer(
                  height: screenWidth * 0.170,
                  width: screenWidth * 0.170,
                  color: posterColor,
                  child: Center(
                    child: (poster != null && poster!.startsWith('http'))
                        ? Image.network(
                            poster!,
                            fit: BoxFit.cover,
                            cacheWidth: 300,
                          )
                        : const Text('포스터'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.049),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activityName,
                          style: TextStyle(
                            fontSize: screenWidth * 0.058,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6, right: screenWidth * 0.036),
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
              ],
            ),
          ),
          SizedBox(
            height: 48,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: selectMode
                  ? [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 0.5, color: Colors.grey),
                            ),
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: appPrimaryColor,
                            ),
                            onPressed: onActivitySelected,
                            child: const Text(
                              '이 활동으로 작성하기',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ]
                  : [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 0.5, color: Colors.grey),
                              right: BorderSide(width: 0.5, color: Colors.grey),
                            ),
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: appPrimaryColor,
                            ),
                            onPressed: onActivityInformationButtonPressed,
                            child: const Text(
                              '활동 정보',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 0.5, color: Colors.grey),
                            ),
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: appPrimaryColor,
                            ),
                            onPressed: onFindPartyButtonPressed,
                            child: const Text(
                              '파티 찾아보기',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ],
            ),
          ),
        ],
      ),
    );
  }

  TableRow activityDetailRow(String label, String value, double screenWidth) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.007,
            vertical: 1,
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
