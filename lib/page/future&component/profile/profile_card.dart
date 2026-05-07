import 'package:flutter/material.dart';

class ProfileCardBasic extends StatefulWidget {
  final List<String> profileContent;
  const ProfileCardBasic({super.key, required this.profileContent});

  @override
  State<ProfileCardBasic> createState() => _ProfileCardBasicState();
}

class _ProfileCardBasicState extends State<ProfileCardBasic> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 185.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20.0)),
          color: Color(0xFFFDFDFD),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0,bottom: 20.0),
                  child: Container(width:80.0,height: 80.0,
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
                  padding: EdgeInsets.only(left: 20.0, top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
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
                                child: Center(child: Text('이름')),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left:8.0,top:3.0,right: 3.0, bottom: 3.0),
                                child: Align(alignment: Alignment.centerLeft, child: Text(widget.profileContent[0])),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(3),
                                child: Center(child: Text('기술')),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left:8.0,top:3.0,right: 3.0, bottom: 3.0),
                                child: Align(alignment: Alignment.centerLeft, child: Text(widget.profileContent[1])),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(3),
                                child: Center(child: Text('소속')),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left:8.0,top:3.0,right: 3.0, bottom: 3.0),
                                child: Align(alignment: Alignment.centerLeft, child: Text(widget.profileContent[2])),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(3),
                                child: Center(child: Text('전공')),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left:8.0,top:3.0,right: 3.0, bottom: 3.0),
                                child: Align(alignment: Alignment.centerLeft, child: Text(widget.profileContent[3])),
                              ),
                            ],
                          ),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Color(0xFF10B880),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.zero,
                          minimumSize: Size(50.0, 0.0),
                          fixedSize: Size(100.0, 30.0),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Text(
                          '프로필 수정',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
