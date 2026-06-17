import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/find_data_structures.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/data/providers/recent_searched_activity_provider.dart';
import 'package:party_maker/presentation/page/etc/find_activity/activity_card_find.dart';
import 'package:party_maker/presentation/page/future&component/component/load_failed_view.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

import 'find_activity_body1.dart';

class FindActivitySearchNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }
}

final findActivitySearchProvider =
    NotifierProvider.autoDispose<FindActivitySearchNotifier, String>(
      FindActivitySearchNotifier.new,
    );

class FindActivity extends ConsumerStatefulWidget {
  final List<ActivityItem> activityList;
  final bool selectMode;
  const FindActivity({super.key, required this.activityList, this.selectMode = false});

  @override
  ConsumerState<FindActivity> createState() => FindActivityState();
}

class FindActivityState extends ConsumerState<FindActivity> {
  late ScrollController scrollController;
  late TextEditingController activitySearchController;
  late FocusNode activitySearchFocusNode;
  late List<ActivityItem> activityList;
  bool isLoading = true;
  bool loadFailed = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    activitySearchController = TextEditingController();
    activitySearchFocusNode = FocusNode();
    activityList = widget.activityList;
    fetchActivityList();
  }

  Future<void> fetchActivityList({bool force = false}) async {
    try {
      final result = await ref
          .read(findRepositoryProvider)
          .getActivityList([], forceRefresh: force);
      if (mounted) setState(() {
        activityList = result;
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
    fetchActivityList(force: true);
  }

  @override
  void dispose() {
    scrollController.dispose();
    activitySearchController.dispose();
    activitySearchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final activityName = ref.watch(findActivitySearchProvider);
    final searchedList = activityList
        .where((activity) => activityName.isEmpty || activity.activityName.contains(activityName))
        .toList();

    return BasicLayout(
      title: '활동 찾기',
      body: RefreshIndicator(
        onRefresh: () => fetchActivityList(force: true),
        color: appPrimaryColor,
        child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          left: screenWidth * 0.036,
          top: 13,
          right: screenWidth * 0.036,
        ),
        itemCount: (isLoading || searchedList.isEmpty) ? 1 : searchedList.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FindActivityBody1(
                  onActivitySearch: onActivitySearch,
                  onFilterApplyButtonPressed: onFilterButtonPressed,
                  activityName: activityName,
                  activityCount: searchedList.length,
                  searchController: activitySearchController,
                  searchFocusNode: activitySearchFocusNode,
                ),
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: CircularProgressIndicator(color: appPrimaryColor),
                    ),
                  )
                else if (loadFailed)
                  LoadFailedView(onRetry: retryFetch)
                else if (searchedList.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text(
                        '활동이 없습니다.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenWidth * 0.041,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }
          final activity = searchedList[index - 1];
          return RepaintBoundary(
            child: ActivityCardFind(
              activityName: activity.activityName,
              poster: activity.poster,
              timePlace: ['${activity.startDate} ~ ${activity.endDate}', activity.location],
              onActivityInformationButtonPressed: () =>
                  onActivityInformationButtonPressed(activity),
              onFindPartyButtonPressed: () =>
                  onFindPartyButtonPressed(activity.activityName),
              selectMode: widget.selectMode,
              onActivitySelected: () => Navigator.pop(context, {
                'id': activity.id,
                'activityName': activity.activityName,
              }),
            ),
          );
        },
      ),
      ),
      bottomNavigationBar: true,
    );
  }

  void onActivitySearch() {
    activitySearchFocusNode.unfocus();
    Future.delayed(const Duration(milliseconds: 10), () {
      if (mounted) {
        FocusScope.of(context).requestFocus(activitySearchFocusNode);
      }
    });
    ref.read(findActivitySearchProvider.notifier).setQuery(activitySearchController.text);
  }

  void onFilterButtonPressed() {
    Navigator.pushNamed(
      context,
      PageRoutes.findActivityFilter,
      arguments: {
        'filterData': <FilterItem>[],
        'detailCategory': <String, List<String>>{},
      },
    );
  }

  void onActivityInformationButtonPressed(ActivityItem activity) async {
    ref.read(recentSearchedActivityProvider.notifier).record(activity);
    String detail = '';
    try {
      final data = await ref
          .read(findRepositoryProvider)
          .getActivityDetail('${activity.id}');
      detail = data['description']?.toString() ?? '';
    } catch (_) {}
    if (mounted) {
      Navigator.pushNamed(
        context,
        PageRoutes.activityInformation,
        arguments: {
          'activityName': activity.activityName,
          'activityOverview': '',
          'activityDetail': detail,
          'leaderProfile': <String>[],
          'position': <String>[],
          'poster': activity.poster,
        },
      );
    }
  }

  void onFindPartyButtonPressed(String id) {
    Navigator.pushNamed(
      context,
      PageRoutes.findParty,
      arguments: {'partyList': <PartyItem>[]},
    );
  }
}
