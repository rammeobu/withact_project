import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/data/models/find_data_structures.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/data/providers/recent_searched_activity_provider.dart';
import 'package:party_maker/presentation/page/etc/find_activity/activity_card_find.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

class RecentSearchedActivity extends ConsumerWidget {
  const RecentSearchedActivity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final recent = ref.watch(recentSearchedActivityProvider);

    return BasicLayout(
      title: '최근 검색한 활동',
      body: recent.isEmpty
          ? Center(
              child: Text(
                '최근 검색한 활동이 없습니다.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenWidth * 0.041,
                ),
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.only(
                left: screenWidth * 0.036,
                top: 13,
                right: screenWidth * 0.036,
                bottom: 17,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: recent
                    .map(
                      (activity) => RepaintBoundary(
                        child: ActivityCardFind(
                          activityName: activity.activityName,
                          timePlace: [
                            '${activity.startDate} ~ ${activity.endDate}',
                            activity.location,
                          ],
                          onActivityInformationButtonPressed: () =>
                              onActivityInformationButtonPressed(
                                context,
                                ref,
                                activity,
                              ),
                          onFindPartyButtonPressed: () =>
                              onFindPartyButtonPressed(context),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
      bottomNavigationBar: true,
    );
  }

  Future<void> onActivityInformationButtonPressed(
    BuildContext context,
    WidgetRef ref,
    ActivityItem activity,
  ) async {
    ref.read(recentSearchedActivityProvider.notifier).record(activity);
    String detail = '';
    try {
      final data = await ref
          .read(findRepositoryProvider)
          .getActivityDetail('${activity.id}');
      detail = data['description']?.toString() ?? '';
    } catch (_) {}
    if (context.mounted) {
      Navigator.pushNamed(
        context,
        PageRoutes.activityInformation,
        arguments: {
          'activityName': activity.activityName,
          'activityOverview': '',
          'activityDetail': detail,
          'leaderProfile': <String>[],
          'position': <String>[],
          'poster': null,
        },
      );
    }
  }

  void onFindPartyButtonPressed(BuildContext context) {
    Navigator.pushNamed(
      context,
      PageRoutes.findParty,
      arguments: {'partyList': <PartyItem>[]},
    );
  }
}
