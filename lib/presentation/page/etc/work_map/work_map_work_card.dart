import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

import '../../future&component/layout/default_container.dart';

class WorkMapWorkCard extends StatelessWidget {
  final String name;
  final String? poster;
  final List<String> timePlace;
  final VoidCallback? onDetailButtonPressed;
  final VoidCallback? onPartyFindButtonPressed;
  const WorkMapWorkCard({
    super.key,
    required this.name,
    this.poster,
    required this.timePlace,
    required this.onDetailButtonPressed,
    required this.onPartyFindButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 169,
      width: screenWidth,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(screenWidth * 0.049),
        ),
        color: cardColor,
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.029),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: DefaultContainer(
                          height: screenWidth * 0.170,
                          width: screenWidth * 0.170,
                          color: posterColor,
                          child: Center(
                            child:
                                (poster != null && poster!.startsWith('http'))
                                ? Image.network(
                                    poster!,
                                    fit: BoxFit.cover,
                                    cacheWidth: 300,
                                  )
                                : const Text('포스터'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.049),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Text(
                                name,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.058,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: screenWidth * 0.036,
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
                                  workDetailRow('일시', timePlace[0], screenWidth),
                                  workDetailRow('장소', timePlace[1], screenWidth),
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
            ),
            Expanded(
              flex: 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.fromLTRB(
                          top: const BorderSide(width: 0.5, color: Colors.grey),
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
                        child: const Text(
                          '활동 설명',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.fromLTRB(
                          top: const BorderSide(width: 0.5, color: Colors.grey),
                        ),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: appPrimaryColor,
                        ),
                        onPressed: onPartyFindButtonPressed,
                        child: const Text(
                          '파티 찾기',
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
      ),
    );
  }

  TableRow workDetailRow(String label, String value, double screenWidth) {
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
