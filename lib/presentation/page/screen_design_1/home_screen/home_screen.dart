import 'dart:io';

import 'package:flutter/material.dart';

import '../../future&component/layout/basic_layout.dart';
import '../../future&component/profile/profile_card.dart';
import '../../future&component/work/work_card/work_card.dart';

class HomeScreen extends StatefulWidget {
  final String? logo;
  final List<String> profileContent;
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
      ['PM', 'FE', 'BE', '1', '2', '3', '4'],
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
  HomeScreen({super.key, this.logo, required this.profileContent});

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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return BasicLayout(
      needTitleExpand: true,
      needWidget: [
        (widget.logo != null) ? Image.file(File(widget.logo!)) : Container(),
      ],
      actions: [
        ElevatedButton.icon(
          onPressed: onWorkPartySearchButtonPressed,
          label: const Text('활동/파티 검색', style: TextStyle(fontSize: 15.0)),
          icon: const Icon(Icons.search, size: 30.0),
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(225.0, 20.0),
            foregroundColor: const Color(0xFFBFBFC4),
            backgroundColor: const Color(0xFF636370),
          ),
        ),
        SizedBox(width: screenWidth * 0.07),
        IconButton(
          onPressed: notification,
          icon: const Icon(Icons.notifications),
        ),
        SizedBox(width: screenWidth * 0.04),
      ],
      body: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.005),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ProfileCardBasic(
              profileContent: widget.profileContent,
              onProfileEditButtonPressed: onProfileEditButtonPressed,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      '현재 $_selectedMode중인 대외활동',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_horiz_outlined),
                    onSelected: (mode) {
                      setState(() {
                        _selectedMode = mode;
                      });

                      _scrollController.jumpTo(0.0);
                    },
                    itemBuilder: (BuildContext context) => [
                      const PopupMenuItem(value: '모집', child: Text('모집중인 활동')),
                      const PopupMenuItem(value: '참여', child: Text('참여중인 활동')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton(
                    onPressed: addWork,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(10, 10),
                      fixedSize: const Size(35, 35),
                      backgroundColor: const Color(0xFF5764F0),
                      foregroundColor: Colors.white,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(20.0),
                      ),
                    ),
                    child: const Icon(Icons.add, size: 30.0),
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
                            []) // 저 리스트 안에 추천하는 활동이 들어갈 예정
                        .map<Widget>(
                          (work) => SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: WorkCardBasic(
                              name: work[0],
                              timePlace: work[1],
                              position: work[2],
                              poster: (work.length > 4) ? work[3] : null,
                              onTap: workCardTap,
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '현재 신청한 대외활동',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
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
                          onProfileCheckPressed: onProfileCheckPressed,
                          onDetailButtonPressed: onDetailButtonPressed,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: true,
      homeSelected: true,
    );
  }

  void notification() {}
  void onWorkPartySearchButtonPressed() {}
  void onProfileEditButtonPressed() {}
  void addWork() {}
  void workCardTap() {}
  void onProfileCheckPressed() {}
  void onDetailButtonPressed() {}
}
