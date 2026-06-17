import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/home_screen_data_structure.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import '../../future&component/component/load_failed_view.dart';
import '../../future&component/layout/basic_layout.dart';

class ParticipatingList extends ConsumerStatefulWidget {
  final List<ActivityCardItem> participating;
  ParticipatingList({super.key, List<ActivityCardItem>? participating})
    : participating = participating ?? [];

  @override
  ConsumerState<ParticipatingList> createState() => ParticipatingListState();
}

class ParticipatingListState extends ConsumerState<ParticipatingList> {
  late List<ActivityCardItem> participating;
  bool isLoading = true;
  bool loadFailed = false;

  @override
  void initState() {
    super.initState();
    participating = widget.participating;
    fetchParticipating();
  }

  Future<void> fetchParticipating() async {
    final userId = ref.read(currentUserProvider);
    if (userId == null) {
      if (mounted) setState(() => isLoading = false);
      return;
    }
    try {
      final result = await ref
          .read(recruitRepositoryProvider)
          .getParticipatingList(userId);
      if (mounted) {
        setState(() {
          participating = result
              .map(
                (recruit) => ActivityCardItem(
                  id: recruit.id,
                  name: recruit.name,
                  timePlace: recruit.timePlace ?? [],
                  position: const [],
                  poster: recruit.poster,
                ),
              )
              .toList();
          isLoading = false;
          loadFailed = false;
        });
      }
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
    fetchParticipating();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return BasicLayout(
      title: '참여 목록',
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: appPrimaryColor),
            )
          : loadFailed
          ? LoadFailedView(onRetry: retryFetch)
          : participating.isEmpty
          ? Center(
              child: Text(
                '참여 내역이 없습니다.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenWidth * 0.041,
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(
                top: 13,
                left: screenWidth * 0.036,
                right: screenWidth * 0.036,
              ),
              child: RefreshIndicator(
                onRefresh: fetchParticipating,
                color: appPrimaryColor,
                child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: participating.length,
                separatorBuilder: (context, i) =>
                    Container(height: 0.5, color: const Color(0xFFBDBDBD)),
                itemBuilder: (context, i) {
                  final activity = participating[i];
                  return InkWell(
                    onTap: () => onActivityTap(context, activity),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            activity.name,
                            style: TextStyle(
                              fontSize: screenWidth * 0.041,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: appPrimaryColor,
                            size: screenWidth * 0.058,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              ),
            ),
      bottomNavigationBar: true,
    );
  }

  void onActivityTap(BuildContext context, ActivityCardItem activity) {
    Navigator.pushNamed(
      context,
      PageRoutes.participatingParty,
      arguments: {
        'activityName': activity.name,
        'activityOverview': '',
        'activityDetail': '',
        'leaderProfile': <String>[],
        'position': activity.position,
        'poster': activity.poster,
        'partyId': activity.id,
      },
    );
  }
}
