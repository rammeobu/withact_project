import 'package:flutter/material.dart';

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
    final double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.2,
      width: screenWidth,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20.0),
        ),
        color: const Color(0xFFFDFDFD),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: const Alignment(0, 0),
                        child: DefaultContainer(
                          height: 70,
                          width: 70,
                          color: const Color(0xffe3e5e9),
                          child: Center(
                            child:
                                (poster != null && poster!.startsWith('http'))
                                ? Image.network(poster!, fit: BoxFit.cover)
                                : const Text('포스터'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: screenHeight * 0.008,
                              ),
                              child: Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Table(
                                border: TableBorder.all(
                                  color: Colors.grey,
                                  width: 0.5,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                columnWidths: const {
                                  0: FixedColumnWidth(40),
                                  1: FlexColumnWidth(),
                                },
                                children: [
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 3,
                                          top: screenHeight * 0.001,
                                          right: 3,
                                          bottom: screenHeight * 0.001,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            '일시',
                                            style: TextStyle(fontSize: 13.0),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 8,
                                          top: screenHeight * 0.001,
                                          right: 3,
                                          bottom: screenHeight * 0.001,
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
                                        padding: EdgeInsets.only(
                                          left: 3,
                                          top: screenHeight * 0.001,
                                          right: 3,
                                          bottom: screenHeight * 0.001,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            '장소',
                                            style: TextStyle(fontSize: 13.0),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 8,
                                          top: screenHeight * 0.001,
                                          right: 3,
                                          bottom: screenHeight * 0.001,
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
                          foregroundColor: const Color(0xFF5764F0),
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
                          foregroundColor: const Color(0xFF5764F0),
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
}
