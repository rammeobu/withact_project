import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/recruit_data_structures.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import '../../future&component/layout/basic_layout.dart';
import 'apply_party_card/recruit_card.dart';

class RecruitList extends ConsumerStatefulWidget {
  final List<RecruitItem>? apply;
  const RecruitList({super.key, this.apply});

  @override
  ConsumerState<RecruitList> createState() => RecruitListState();
}

class RecruitListState extends ConsumerState<RecruitList> {
  List<RecruitItem> recruitList = [];
  bool isLoading = true;
  final ScrollController listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    recruitList = widget.apply ?? [];
    fetchRecruitList();
  }

  @override
  void dispose() {
    listScrollController.dispose();
    super.dispose();
  }

  Future<void> fetchRecruitList() async {
    try {
      final result = await ref.read(recruitRepositoryProvider).getRecruitList();
      if (mounted) setState(() {
        recruitList = result;
        isLoading = false;
      });
    } catch (_) {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return BasicLayout(
      title: '모집 목록',
      body: Padding(
        padding: const EdgeInsets.only(top: 13),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: appPrimaryColor),
              )
            : recruitList.isEmpty
                ? Center(
                    child: Text(
                      '모집 내역이 없습니다.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.041,
                      ),
                    ),
                  )
                : SizedBox(
                    height: 506,
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: listScrollController,
                      child: ListView.builder(
                        controller: listScrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: recruitList.length,
                        itemBuilder: (context, index) {
                          final apply = recruitList[index];
                          return RepaintBoundary(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.024,
                              ),
                              child: Container(
                                width: screenWidth * 0.85,
                                child: RecruitCard(
                                  name: apply.name,
                                  timePlace: apply.timePlace ?? [],
                                  applyStatus: apply.applyStatus ?? '',
                                  poster: apply.poster,
                                  onDetailButtonPressed: () =>
                                      onDetailButtonPressed(
                                        apply.name,
                                        apply.poster,
                                      ),
                                  onAnnouncementManageButtonPressed: () =>
                                      onAnnouncementManageButtonPressed(
                                          apply.name, apply.id),
                                  onCheckApplicantButtonPressed: () =>
                                      onCheckApplicantButtonPressed(apply.id),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
      ),
      bottomNavigationBar: true,
    );
  }

  void onDetailButtonPressed(String name, String? poster) {
    Navigator.pushNamed(
      context,
      PageRoutes.activityInformation,
      arguments: {
        'activityName': name,
        'activityOverview': '',
        'activityDetail': '',
        'leaderProfile': <String>[],
        'position': <String>[],
        'poster': poster,
      },
    );
  }

  void onAnnouncementManageButtonPressed(String name, int partyId) {
    Navigator.pushNamed(
      context,
      PageRoutes.recruitAnnouncement,
      arguments: {
        'activityName': name,
        'partyNameIntroduction': '',
        'position': <String>[],
        'preferences': null,
        'partyId': partyId,
      },
    );
  }

  void onCheckApplicantButtonPressed(int partyId) {
    Navigator.pushNamed(
      context,
      PageRoutes.applicantCheck,
      arguments: {'position': <String>[], 'partyId': partyId},
    );
  }
}
