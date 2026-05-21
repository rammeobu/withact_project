import 'package:flutter/material.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/data/models/recruit_data_structures.dart';
import '../../future&component/layout/basic_layout.dart';
import 'apply_party_card/recruit_card.dart';

class RecruitList extends StatefulWidget {
  final List<RecruitItem> apply;
  RecruitList({super.key, List<RecruitItem>? apply})
    : apply =
          apply ??
          [
            const RecruitItem(
              name: '활동 1',
              timePlace: ['시간', '장소'],
              applyStatus: '지원 중',
              poster: '',
            ),
            const RecruitItem(
              name: '활동 2',
              timePlace: ['시간', '장소'],
              applyStatus: '지원 중',
              poster: '',
            ),
            const RecruitItem(
              name: '활동 3',
              timePlace: ['시간', '장소'],
              applyStatus: '지원 중',
              poster: '',
            ),
            const RecruitItem(
              name: '활동 4',
              timePlace: ['시간', '장소'],
              applyStatus: '지원 중',
              poster: '',
            ),
            const RecruitItem(
              name: '활동 5',
              timePlace: ['시간', '장소'],
              applyStatus: '지원 중',
              poster: '',
            ),
            const RecruitItem(
              name: '활동 6',
              timePlace: ['시간', '장소'],
              applyStatus: '지원 중',
              poster: '',
            ),
            const RecruitItem(
              name: '활동 7',
              timePlace: ['시간', '장소'],
              applyStatus: '지원 중',
              poster: '',
            ),
          ];

  @override
  State<RecruitList> createState() => _RecruitListState();
}

class _RecruitListState extends State<RecruitList> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return BasicLayout(
      title: '모집 목록',
      body: Padding(
        padding: const EdgeInsets.only(top: 13),
        child: Center(
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.apply
                    .map(
                      (apply) => RepaintBoundary(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.024,
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: screenWidth * 0.85,
                            ),
                            child: RecruitCard(
                              name: apply.name,
                              timePlace: apply.timePlace,
                              applyStatus: apply.applyStatus,
                              poster: apply.poster,
                              onDetailButtonPressed: () =>
                                  onDetailButtonPressed(apply.name),
                              onAnnouncementManageButtonPressed: () =>
                                  onAnnouncementManageButtonPressed(apply.name),
                              onCheckApplicantButtonPressed: () =>
                                  onCheckApplicantButtonPressed(apply.name),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: true,
    );
  }

  void onDetailButtonPressed(String name) {
    Navigator.pushNamed(
      context,
      PageRoutes.workInformation,
      arguments: {
        'workName': name,
        'workOverview': '',
        'workDetail': '',
        'leaderProfile': <String>[],
        'position': <String>[],
        'poster': null,
      },
    );
  }

  void onAnnouncementManageButtonPressed(String name) {
    Navigator.pushNamed(
      context,
      PageRoutes.recruitAnnouncement,
      arguments: {
        'workName': name,
        'partyNameIntroduction': '',
        'position': <String>[],
        'preferences': null,
      },
    );
  }

  void onCheckApplicantButtonPressed(String name) {
    Navigator.pushNamed(
      context,
      PageRoutes.applicantCheck,
      arguments: {'position': <String>[]},
    );
  }
}
