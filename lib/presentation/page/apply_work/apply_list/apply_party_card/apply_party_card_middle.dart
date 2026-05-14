import 'package:flutter/material.dart';

class ApplyPartyCardMiddle extends StatelessWidget {
  final String name;
  final List<String> timePlace;
  const ApplyPartyCardMiddle({
    super.key,
    required this.name,
    required this.timePlace,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 13,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, right: 15.0),
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
                      const Padding(
                        padding: EdgeInsets.all(3),
                        child: Center(
                          child: Text('일시', style: TextStyle(fontSize: 13.0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          top: 3.0,
                          right: 3.0,
                          bottom: 3.0,
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
                      const Padding(
                        padding: EdgeInsets.all(3),
                        child: Center(
                          child: Text('장소', style: TextStyle(fontSize: 13.0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          top: 3.0,
                          right: 3.0,
                          bottom: 3.0,
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
