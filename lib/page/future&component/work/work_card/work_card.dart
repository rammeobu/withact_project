import 'package:flutter/material.dart';
import 'package:party_maker/page/future&component/work/work_card/work_card_body.dart';
import '../../layout/default_container.dart';

class WorkCardBasic extends StatelessWidget {
  final String name;
  final List<String> timePlace;
  final List<String> position;


  const WorkCardBasic({super.key, required this.name, required this.timePlace, required this.position});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20.0)),
          color: Color(0xFFFDFDFD),
          child: Row(
            children: [
              Flexible(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment(0, -0.7),
                    child: DefaultContainer(
                      height: 75,
                      width: 75,
                      color: Color(0xffe3e5e9),
                      child: Center(child: Text('포스터')),
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
                    children: [Padding(
                      padding: const EdgeInsets.only(top:10.0, left: 15.0, bottom:10.0),
                      child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                    ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0,right:30.0),
                        child: Table(
                          border: TableBorder.all(
                            color: Colors.grey,
                            width: 0.5,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          columnWidths: {
                            0: FixedColumnWidth(40),
                            1: FlexColumnWidth(),
                          },
                          children: [
                            TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(3),
                                  child: Center(child: Text('일시',style: TextStyle(
                                    fontSize: 13.0,
                                  ))),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
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
                                Padding(
                                  padding: EdgeInsets.all(3),
                                  child: Center(child: Text('장소',style: TextStyle(
                                    fontSize: 13.0,
                                  ))),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
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
                      SizedBox(height:3.0),
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
    );
  }
}

class WorkCardApply extends StatelessWidget {
  final String name;
  final List<String> timePlace;
  final String applyStatus;
  final VoidCallback? onPressed;
  const WorkCardApply({
    super.key,
    required this.name,
    required this.timePlace,
    required this.applyStatus,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20.0)),
          color: Color(0xFFFDFDFD),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment(0, 0),
                          child: DefaultContainer(
                            height: 70,
                            width: 70,
                            color: Color(0xffe3e5e9),
                            child: Center(child: Text('포스터')),
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
                                padding: const EdgeInsets.only(top:5.0),
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: Table(
                                  border: TableBorder.all(
                                    color: Colors.grey,
                                    width: 0.5,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  columnWidths: {
                                    0: FixedColumnWidth(40),
                                    1: FlexColumnWidth(),
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(3),
                                          child: Center(child: Text('일시',style: TextStyle(
                                            fontSize: 13.0,
                                          ))),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
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
                                        Padding(
                                          padding: EdgeInsets.all(3),
                                          child: Center(child: Text('장소',style: TextStyle(
                                            fontSize: 13.0,
                                          ))),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
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
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: BoxBorder.fromLTRB(top: BorderSide(width: 0.5,color: Colors.grey), right: BorderSide(width: 0.5,color: Colors.grey)),
                        ),
                        child: Center(child: Text(applyStatus)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          decoration: BoxDecoration(
                            border: BoxBorder.fromLTRB(top: BorderSide(width: 0.5,color: Colors.grey), left: BorderSide(width: 0.0,color: Colors.grey)),
                          ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Color(0xFF5764F0),
                          ),
                          onPressed: onPressed,
                          child: Text(
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
