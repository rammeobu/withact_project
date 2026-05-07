import 'package:flutter/material.dart';

import '../future&component/layout/basic_layout.dart';
import '../future&component/profile/profile_card.dart';
import '../future&component/work/work_card/work_card.dart';


class HomeScreen extends StatefulWidget {
  List<List<dynamic>>? recruitCard = [
    [
      '캡스톤',
      ['일시', '장소'],
      ['PM', 'FE', 'BE'],
    ],
    [
      '생성형AI프로젝트',
      ['일시', '장소'],
      ['PM', 'FE', 'BE'],
    ],
    [
      '휴먼AI인터랙션',
      ['일시', '장소'],
      ['PM', 'FE', 'BE','1','2','3','4'],
    ],
  ];
  List<List<dynamic>>? participateCard = [
    [
      '컴퓨터비전',
      ['일시', '장소'],
      ['PM', 'FE', 'BE'],
    ],
    [
      '클라우드컴퓨팅',
      ['일시', '장소'],
      ['PM', 'FE', 'BE'],
    ],
    [
      '데이터마이닝',
      ['일시', '장소'],
      ['PM', 'FE', 'BE'],
    ],
  ];
  List<List<dynamic>>? applyCard = [
    [
      '활동 이름',
      ['일시', '장소'],
      '대기 중',
    ],
    [
      '활동 이름',
      ['일시', '장소'],
      '심사 중',
    ],
    [
      '활동 이름',
      ['일시', '장소'],
      '대기 중',
    ],
  ];
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  String _selectedMode = '모집';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasicLayout(
      title: 'PM',
      actions: [
        ElevatedButton.icon(
          onPressed: () {},
          label: Text('활동/파티 검색', style: TextStyle(fontSize: 15.0)),
          icon: Icon(Icons.search, size: 30.0),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(225.0, 20.0),
            foregroundColor: Color(0xFFBFBFC4),
            backgroundColor: Color(0xFF636370),
          ),
        ),
        SizedBox(width: 37.5),
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
      ],
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ProfileCardBasic(profileContent: ['1', '2', '3', '4']),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      '현재 $_selectedMode중인 대외활동',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: PopupMenuButton<String>(
                    icon: Icon(Icons.more_horiz_outlined),
                    onSelected: (mode) {
                      setState(() {
                        _selectedMode = mode;
                      });

                      _scrollController.jumpTo(0.0);
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(value: '모집', child: Text('모집중인 활동')),
                      PopupMenuItem(value: '참여', child: Text('참여중인 활동')),
                    ],
                  ),
                ), // onPressed: 모드 변경
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(10, 10),
                      fixedSize: Size(40, 40),
                      backgroundColor: Color(0xFF5764F0),
                      foregroundColor: Colors.white,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(20.0),
                      ),
                    ),
                    child: Icon(Icons.add, size: 30.0),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    ((_selectedMode == '모집'
                                ? widget.recruitCard
                                : widget.participateCard) ??
                            [])
                        .map<Widget>(
                          (work) => SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: WorkCardBasic(
                              name: work[0],
                              timePlace: work[1],
                              position: work[2],
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '현재 신청한 대외활동',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: (widget.applyCard ?? [])
                    .map(
                      (work) => SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: WorkCardApply(
                          name: work[0],
                          timePlace: work[1],
                          applyStatus: work[2],
                          onPressed: () {},
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
