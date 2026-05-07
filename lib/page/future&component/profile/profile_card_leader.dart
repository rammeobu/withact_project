import 'package:flutter/material.dart';

class ProfileCardLeader extends StatefulWidget {
  final List<String> profileContent;
  const ProfileCardLeader({super.key, required this.profileContent});

  @override
  State<ProfileCardLeader> createState() => _ProfileCardLeaderState();
}

class _ProfileCardLeaderState extends State<ProfileCardLeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 130.0,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20.0),
          ),
          color: Color(0xFFECEEFD),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFECEEFD),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 65,
                      color: Color(0xFF5764F0),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '파티장',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xff5764f0),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: EdgeInsets.zero,
                              side: BorderSide(color: Colors.grey, width:0.5),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10.0)),
                              fixedSize: Size(80, 25),
                              minimumSize: Size(0, 0),
                            ),
                            onPressed: () {},
                            child: Text('문의하기', style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                        ],
                      ),
                      Table(
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
                                child: Center(child: Text('이름',style: TextStyle(
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
                                  child: Text(widget.profileContent[0]),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(3),
                                child: Center(child: Text('기술',style: TextStyle(
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
                                  child: Text(widget.profileContent[1]),
                                ),
                              ),
                            ],
                          ),
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
