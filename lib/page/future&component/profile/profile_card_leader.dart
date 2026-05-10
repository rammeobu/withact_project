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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.02),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: screenHeight * 0.135,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20.0),
          ),
          color: const Color(0xFFECEEFD),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    width: screenHeight * 0.11,
                    height: screenHeight * 0.105,
                    decoration: const BoxDecoration(
                      color: Color(0xFFECEEFD),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
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
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    bottom: screenHeight * 0.005,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
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
                              side: const BorderSide(
                                color: Colors.grey,
                                width: 0.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(
                                  10.0,
                                ),
                              ),
                              fixedSize: const Size(80, 23),
                              minimumSize: const Size(0, 0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              '문의하기',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Table(
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
                                padding: EdgeInsets.symmetric(
                                  horizontal: 3.0,
                                  vertical: screenHeight * 0.001,
                                ),
                                child: const Center(
                                  child: Text(
                                    '이름',
                                    style: TextStyle(fontSize: 12.0),
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
                                  child: Text(
                                    widget.profileContent[0],
                                    style: const TextStyle(fontSize: 12.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 3.0,
                                  vertical: screenHeight * 0.001,
                                ),
                                child: const Center(
                                  child: Text(
                                    '기술',
                                    style: TextStyle(fontSize: 12.0),
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
                                  child: Text(
                                    widget.profileContent[1],
                                    style: const TextStyle(fontSize: 12.0),
                                  ),
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
