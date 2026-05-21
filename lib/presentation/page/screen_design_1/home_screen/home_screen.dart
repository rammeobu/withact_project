import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/home_screen_data_structure.dart';
import 'package:party_maker/data/models/notify_data_structure.dart';
import 'package:party_maker/data/models/find_data_structures.dart';

import '../../future&component/layout/basic_layout.dart';
import '../../future&component/profile/profile_card.dart';
import '../../future&component/work/work_card/work_card.dart';

class _HomeSelectedModeNotifier extends Notifier<String> {
  @override
  String build() => '모집';
}

final homeSelectedModeProvider =
    NotifierProvider.autoDispose<_HomeSelectedModeNotifier, String>(
      _HomeSelectedModeNotifier.new,
    );

class HomeScreen extends ConsumerStatefulWidget {
  final String? logo;
  final List<String> profileContent;
  List<WorkCardItem>? recruitCard;
  List<WorkCardItem>? participateCard;
  List<ApplyCardItem>? applyCard;
  HomeScreen({
    super.key,
    this.logo,
    required this.profileContent,
    List<WorkCardItem>? recruitCard,
    List<WorkCardItem>? participateCard,
    List<ApplyCardItem>? applyCard,
  }) : recruitCard =
           recruitCard ??
           [
             const WorkCardItem(
               name: '캡스톤',
               timePlace: ['일시', '장소'],
               position: ['PM', 'FE', 'BE'],
             ),
             const WorkCardItem(
               name: '생성형AI프로젝트',
               timePlace: ['일시', '장소'],
               position: ['PM', 'FE', 'BE'],
             ),
             const WorkCardItem(
               name: '휴먼AI인터랙션',
               timePlace: ['일시', '장소'],
               position: ['PM', 'FE', 'BE', '1', '2', '3', '4'],
             ),
           ],
       participateCard =
           participateCard ??
           [
             const WorkCardItem(
               name: '컴퓨터비전',
               timePlace: ['일시', '장소'],
               position: ['PM', 'FE', 'BE'],
             ),
             const WorkCardItem(
               name: '클라우드컴퓨팅',
               timePlace: ['일시', '장소'],
               position: ['PM', 'FE', 'BE'],
             ),
             const WorkCardItem(
               name: '데이터마이닝',
               timePlace: ['일시', '장소'],
               position: ['PM', 'FE', 'BE'],
             ),
           ],
       applyCard =
           applyCard ??
           [
             const ApplyCardItem(
               name: '활동 이름',
               timePlace: ['일시', '장소'],
               applyStatus: '대기 중',
             ),
             const ApplyCardItem(
               name: '활동 이름',
               timePlace: ['일시', '장소'],
               applyStatus: '심사 중',
             ),
             const ApplyCardItem(
               name: '활동 이름',
               timePlace: ['일시', '장소'],
               applyStatus: '대기 중',
             ),
           ];

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final selectedMode = ref.watch(homeSelectedModeProvider);

    return BasicLayout(
      needTitleExpand: true,
      needWidget: [
        (widget.logo != null) ? Image.file(File(widget.logo!)) : Container(),
      ],
      actions: [
        ElevatedButton.icon(
          onPressed: onWorkSearchButtonPressed,
          label: Text('활동 검색', style: TextStyle(fontSize: screenWidth * 0.036)),
          icon: Icon(Icons.search, size: screenWidth * 0.073),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(screenWidth * 0.547, 23),
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF8D6E63),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.07,
            right: screenWidth * 0.04,
          ),
          child: IconButton(
            onPressed: notification,
            icon: const Icon(Icons.notifications),
          ),
        ),
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileCardBasic(
                profileContent: widget.profileContent,
                onProfileEditButtonPressed: onProfileEditButtonPressed,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 19, bottom: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.036),
                        child: Text(
                          '현재 $selectedMode중인 대외활동',
                          style: sectionTitleFont,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: PopupMenuButton<String>(
                        icon: const Icon(Icons.more_horiz_outlined),
                        onSelected: (mode) {
                          ref.read(homeSelectedModeProvider.notifier).state =
                              mode;
                          scrollController.jumpTo(0.0);
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            value: '모집',
                            child: Text('모집중인 활동'),
                          ),
                          const PopupMenuItem(
                            value: '참여',
                            child: Text('참여중인 활동'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: screenWidth * 0.024),
                      child: ElevatedButton(
                        onPressed: addWork,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(10, 10),
                          fixedSize: Size(
                            screenWidth * 0.085,
                            screenWidth * 0.085,
                          ),
                          backgroundColor: appPrimaryColor,
                          foregroundColor: Colors.white,
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(
                              screenWidth * 0.049,
                            ),
                          ),
                        ),
                        child: Icon(Icons.add, size: screenWidth * 0.073),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      ((selectedMode == '모집'
                                  ? widget.recruitCard
                                  : widget.participateCard) ??
                              [])
                          .map<Widget>(
                            (work) => RepaintBoundary(
                              child: SizedBox(
                                width: screenWidth * 0.85,
                                child: WorkCardBasic(
                                  name: work.name,
                                  timePlace: work.timePlace,
                                  position: work.position,
                                  poster: work.poster,
                                  onTap: () => workCardTap(work),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.036,
                  top: 19,
                  bottom: 7,
                ),
                child: Text('현재 신청한 대외활동', style: sectionTitleFont),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: (widget.applyCard ?? [])
                      .map(
                        (work) => RepaintBoundary(
                          child: SizedBox(
                            width: screenWidth * 0.85,
                            child: WorkCardApply(
                              name: work.name,
                              timePlace: work.timePlace,
                              applyStatus: work.applyStatus,
                              onProfileCheckPressed: () =>
                                  onProfileCheckPressed(work),
                              onDetailButtonPressed: () =>
                                  onDetailButtonPressed(work),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: true,
      homeSelected: true,
    );
  }

  void notification() {
    Navigator.pushNamed(
      context,
      PageRoutes.notify,
      arguments: {'notification': <NotificationItem>[], 'position': <String>[]},
    );
  }

  void onWorkSearchButtonPressed() {
    Navigator.pushNamed(
      context,
      PageRoutes.findWork,
      arguments: {'workList': <WorkItem>[]},
    );
  }

  void onProfileEditButtonPressed() {
    Navigator.pushNamed(
      context,
      PageRoutes.profileEdit,
      arguments: {
        'profileContent': List.generate(
          4,
          (i) =>
              i < widget.profileContent.length ? widget.profileContent[i] : '',
        ),
        'introduction': '',
        'spec': '',
        'favorites': <String>['', '', ''],
      },
    );
  }

  void addWork() {
    final selectedMode = ref.read(homeSelectedModeProvider);
    if (selectedMode == '모집') {
      Navigator.pushNamed(context, PageRoutes.workRecruit);
    } else {
      Navigator.pushNamed(
        context,
        PageRoutes.findWork,
        arguments: {'workList': <WorkItem>[]},
      );
    }
  }

  void workCardTap(WorkCardItem work) {
    final selectedMode = ref.read(homeSelectedModeProvider);
    if (selectedMode == '모집') {
      Navigator.pushNamed(
        context,
        PageRoutes.workInformation,
        arguments: {
          'workName': work.name,
          'workOverview': '',
          'workDetail': '',
          'leaderProfile': List.generate(
            2,
            (i) => i < widget.profileContent.length
                ? widget.profileContent[i]
                : '',
          ),
          'position': work.position,
          'poster': work.poster,
        },
      );
    } else {
      Navigator.pushNamed(
        context,
        PageRoutes.participatingParty,
        arguments: {
          'workName': work.name,
          'workOverview': '',
          'workDetail': '',
          'leaderProfile': List.generate(
            2,
            (i) => i < widget.profileContent.length
                ? widget.profileContent[i]
                : '',
          ),
          'position': work.position,
          'poster': work.poster,
        },
      );
    }
  }

  void onProfileCheckPressed(ApplyCardItem work) {
    Navigator.pushNamed(
      context,
      PageRoutes.applyingWork,
      arguments: {'workName': work.name, 'profile': <String>[], 'poster': null},
    );
  }

  void onDetailButtonPressed(ApplyCardItem work) {
    Navigator.pushNamed(
      context,
      PageRoutes.applyWork,
      arguments: {
        'workName': work.name,
        'workOverview': '',
        'workDetail': '',
        'leaderProfile': List.generate(
          2,
          (i) =>
              i < widget.profileContent.length ? widget.profileContent[i] : '',
        ),
        'position': <String>[],
        'poster': null,
      },
    );
  }
}
