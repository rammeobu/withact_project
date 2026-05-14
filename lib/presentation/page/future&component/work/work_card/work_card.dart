import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/future&component/work/work_card/work_card_body.dart';
import '../../layout/default_container.dart';

class WorkCardBasic extends StatelessWidget {
  final String name;
  final String? poster;
  final List<String> timePlace;
  final List<String> position;
  final VoidCallback onTap;

  const WorkCardBasic({
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
    final double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.225,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20.0),
          ),
          color: const Color(0xFFFDFDFD),
          child: InkWell(
            onTap: onTap,
            enableFeedback: true,
            splashFactory: InkRipple.splashFactory,
            child: Row(
              children: [
                Flexible(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                      alignment: const Alignment(0, -0.7),
                      child: DefaultContainer(
                        height: 75,
                        width: 75,
                        color: const Color(0xffe3e5e9),
                        child: Center(
                          child: (poster != null && poster!.startsWith('http'))
                              ? Image.network(poster!, fit: BoxFit.cover)
                              : const Text('포스터'),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 19,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: screenHeight * 0.006,
                            left: 15.0,
                            bottom: screenHeight * 0.006,
                          ),
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 30.0,
                          ),
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
                                      left: 3.0,
                                      top: screenHeight * 0.001,
                                      right: 3.0,
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
                                      left: 8.0,
                                      top: screenHeight * 0.001,
                                      right: 3.0,
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
                                      left: 3.0,
                                      top: screenHeight * 0.001,
                                      right: 3.0,
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
                                      left: 8.0,
                                      top: screenHeight * 0.001,
                                      right: 3.0,
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
                        SizedBox(height: screenHeight * 0.001),
                        Row(
                          children: [
                            Expanded(child: WorkCardBody(position: position)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WorkCardApply extends StatelessWidget {
  final String name;
  final String? poster;
  final List<String> timePlace;
  final String applyStatus;
  final VoidCallback? onDetailButtonPressed;
  final VoidCallback? onProfileCheckPressed;
  const WorkCardApply({
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
    final double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                        child: Center(child: Text(applyStatus)),
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
                            top: const BorderSide(
                              width: 0.5,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF5764F0),
                          ),
                          onPressed: onProfileCheckPressed,
                          child: const Text(
                            '지원서 확인',
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
      ),
    );
  }
}
