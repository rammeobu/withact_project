import 'package:flutter/material.dart';

class ProfileCardApplicant extends StatefulWidget {
  final List<String> profileContent;
  final VoidCallback onTap;
  const ProfileCardApplicant({super.key, required this.profileContent, required this.onTap});

  @override
  State<ProfileCardApplicant> createState() => _ProfileCardApplicantState();
}

class _ProfileCardApplicantState extends State<ProfileCardApplicant> {
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
          color: Color(0xfff0f3f6),
          child: InkWell(
            onTap: widget.onTap,
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
                        color: Color(0xFFFDFDFD),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 65,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  child: Center(child: Text('이름',style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500
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
                                  child: Center(child: Text('역할',style: TextStyle(
                                    fontSize: 13.0,
                                      fontWeight: FontWeight.w500
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
                            ),TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(3),
                                  child: Center(child: Text('기술',style: TextStyle(
                                    fontSize: 13.0,
                                      fontWeight: FontWeight.w500
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
                                    child: Text(widget.profileContent[2]),
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
      ),
    );
  }
}
