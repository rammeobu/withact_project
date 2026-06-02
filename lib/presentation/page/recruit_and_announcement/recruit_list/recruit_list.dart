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
  ConsumerState<RecruitList> createState() => _RecruitListState();
}

class _RecruitListState extends ConsumerState<RecruitList> {
  List<RecruitItem> _recruitList = [];
  bool _isLoading = true;
  final ScrollController _listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _recruitList = widget.apply ?? [];
    _fetchRecruitList();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchRecruitList() async {
    try {
      final result = await ref.read(recruitRepositoryProvider).getRecruitList();
      if (mounted) setState(() {
        _recruitList = result;
        _isLoading = false;
      });
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return BasicLayout(
      title: '모집 목록',
      body: Padding(
        padding: const EdgeInsets.only(top: 13),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: appPrimaryColor),
              )
            : _recruitList.isEmpty
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
                      controller: _listScrollController,
                      child: ListView.builder(
                        controller: _listScrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: _recruitList.length,
                        itemBuilder: (context, index) {
                          final apply = _recruitList[index];
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
                                      onDetailButtonPressed(apply.name),
                                  onAnnouncementManageButtonPressed: () =>
                                      onAnnouncementManageButtonPressed(
                                          apply.name, apply.id),
                                  onCheckApplicantButtonPressed: () =>
                                      onCheckApplicantButtonPressed(apply.name),
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

  void onAnnouncementManageButtonPressed(String name, int partyId) {
    Navigator.pushNamed(
      context,
      PageRoutes.recruitAnnouncement,
      arguments: {
        'workName': name,
        'partyNameIntroduction': '',
        'position': <String>[],
        'preferences': null,
        'partyId': partyId,
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
