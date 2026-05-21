import 'package:flutter/material.dart';

import '../../../../../core/constant.dart';

class ApplyPartyCardMiddle extends StatelessWidget {
  final String name;
  final List<String> timePlace;
  final String applyStatus;
  const ApplyPartyCardMiddle({
    super.key,
    required this.name,
    required this.timePlace,
    required this.applyStatus,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.049),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 14,
                right: screenWidth * 0.036,
                bottom: 7,
              ),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: screenWidth * 0.058,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 6, right: screenWidth * 0.036),
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
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.007),
                        child: Center(child: Text('일시', style: tableCellFont)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.019,
                          top: screenWidth * 0.007,
                          right: screenWidth * 0.007,
                          bottom: screenWidth * 0.007,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(timePlace[0]),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.007),
                        child: Center(child: Text('장소', style: tableCellFont)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.019,
                          top: screenWidth * 0.007,
                          right: screenWidth * 0.007,
                          bottom: screenWidth * 0.007,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(timePlace[1]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
