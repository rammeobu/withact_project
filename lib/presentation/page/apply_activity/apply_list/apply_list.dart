import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/apply_data_structures.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/presentation/page/future&component/component/load_failed_view.dart';
import '../../future&component/layout/basic_layout.dart';
import 'apply_party_card/apply_party_card.dart';

class ApplyList extends ConsumerStatefulWidget {
  final List<ApplyItem> apply;
  ApplyList({super.key, List<ApplyItem>? apply}) : apply = apply ?? [];

  @override
  ConsumerState<ApplyList> createState() => ApplyListState();
}

class ApplyListState extends ConsumerState<ApplyList> {
  late List<ApplyItem> applyList;
  bool isLoading = true;
  bool loadFailed = false;

  @override
  void initState() {
    super.initState();
    applyList = widget.apply;
    fetchApplyList();
  }

  Future<void> fetchApplyList() async {
    final userId = ref.read(currentUserProvider);
    if (userId == null) {
      if (mounted) setState(() => isLoading = false);
      return;
    }
    try {
      final result =
          await ref.read(applyRepositoryProvider).getApplyList(userId);
      if (mounted) setState(() {
        applyList = result;
        isLoading = false;
        loadFailed = false;
      });
    } catch (_) {
      if (mounted) setState(() {
        isLoading = false;
        loadFailed = true;
      });
    }
  }

  void retryFetch() {
    setState(() {
      isLoading = true;
      loadFailed = false;
    });
    fetchApplyList();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return BasicLayout(
      title: '파티 지원 목록',
      body: Padding(
        padding: const EdgeInsets.only(top: 13),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: appPrimaryColor),
              )
            : loadFailed
            ? LoadFailedView(onRetry: retryFetch)
            : applyList.isEmpty
            ? Center(
                child: Text(
                  '지원 내역이 없습니다.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: screenWidth * 0.041,
                  ),
                ),
              )
            : Center(
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: applyList
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
                                  child: ApplyPartyCard(
                                    name: apply.name,
                                    timePlace: apply.timePlace ?? [],
                                    applyStatus: apply.applyStatus,
                                    poster: apply.poster,
                                    onDetailButtonPressed: () =>
                                        onDetailButtonPressed(apply.name),
                                    onCheckProfileButtonPressed: () =>
                                        onCheckProfileButtonPressed(
                                          apply.name,
                                          apply.id,
                                        ),
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
      PageRoutes.activityInformation,
      arguments: {
        'activityName': name,
        'activityOverview': '',
        'activityDetail': '',
        'leaderProfile': <String>[],
        'position': <String>[],
        'poster': null,
      },
    );
  }

  void onCheckProfileButtonPressed(String name, int applicationId) {
    Navigator.pushNamed(
      context,
      PageRoutes.applyingActivity,
      arguments: {
        'activityName': name,
        'profile': <String>[],
        'poster': null,
        'applicationId': applicationId,
      },
    );
  }
}
