import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/home_screen_data_structure.dart';
import 'package:party_maker/data/models/notify_data_structure.dart';
import 'package:party_maker/data/models/find_data_structures.dart';
import 'package:party_maker/data/providers/repository_providers.dart';

import '../../future&component/component/load_failed_view.dart';
import '../../future&component/layout/basic_layout.dart';
import '../../future&component/profile/profile_card.dart';
import '../../future&component/activity/activity_card/activity_card.dart';

class HomeSelectedModeNotifier extends Notifier<String> {
  @override
  String build() => '모집';

  void setMode(String mode) {
    state = mode;
  }
}

final homeSelectedModeProvider =
    NotifierProvider.autoDispose<HomeSelectedModeNotifier, String>(
      HomeSelectedModeNotifier.new,
    );

class HomeScreen extends ConsumerStatefulWidget {
  final String? logo;
  final List<String> profileContent;
  const HomeScreen({
    super.key,
    this.logo,
    required this.profileContent,
  });

  @override
  ConsumerState<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController scrollController = ScrollController();
  List<ActivityCardItem> recruitCard = [];
  List<ActivityCardItem> participateCard = [];
  List<ApplyCardItem> applyCard = [];
  bool recruitLoading = true;
  bool recruitFailed = false;

  @override
  void initState() {
    super.initState();
    fetchHomeCards();
  }

  Future<void> fetchHomeCards() async {
    for (int attempt = 0; attempt < 3; attempt++) {
      try {
        final recruits =
            await ref.read(recruitRepositoryProvider).getRecruitList();
        if (!mounted) return;
        setState(() {
          recruitCard = recruits
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
          recruitLoading = false;
          recruitFailed = false;
        });
        final withRoles = await Future.wait(
          recruits.map((recruit) async {
            List<String> position = const [];
            try {
              final roles = await ref
                  .read(findRepositoryProvider)
                  .getPartyRoles(recruit.id);
              position = roles.map((role) => role.roleName).toList();
            } catch (_) {}
            return ActivityCardItem(
              id: recruit.id,
              name: recruit.name,
              timePlace: recruit.timePlace ?? [],
              position: position,
              poster: recruit.poster,
            );
          }),
        );
        if (mounted) setState(() => recruitCard = withRoles);
        break;
      } catch (_) {
        await Future.delayed(const Duration(milliseconds: 600));
      }
    }
    if (mounted && recruitLoading) {
      setState(() {
        recruitLoading = false;
        recruitFailed = true;
      });
    }
    if (!mounted) return;
    final userId = ref.read(currentUserProvider);
    if (userId != null) {
      await Future.wait([
        (() async {
          try {
            final profile =
                await ref.read(accountRepositoryProvider).getProfile('$userId');
            if (mounted) ref.read(profileProvider.notifier).setProfile(profile);
          } catch (_) {}
        })(),
        (() async {
          try {
            final applies =
                await ref.read(applyRepositoryProvider).getApplyList(userId);
            if (mounted) setState(() {
              applyCard = applies
                  .map(
                    (apply) => ApplyCardItem(
                      applicationId: apply.id,
                      partyId: apply.partyId,
                      name: apply.name,
                      timePlace: apply.timePlace ?? [],
                      applyStatus: apply.applyStatus,
                      introduction: apply.introduction,
                      spec: apply.spec,
                    ),
                  )
                  .toList();
            });
          } catch (_) {}
        })(),
        (() async {
          try {
            final participating = await ref
                .read(recruitRepositoryProvider)
                .getParticipatingList(userId);
            if (mounted) {
              setState(() {
                participateCard = participating
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
              });
            }
            final withRoles = await Future.wait(
              participating.map((recruit) async {
                List<String> position = const [];
                try {
                  final roles = await ref
                      .read(findRepositoryProvider)
                      .getPartyRoles(recruit.id);
                  position = roles.map((role) => role.roleName).toList();
                } catch (_) {}
                return ActivityCardItem(
                  id: recruit.id,
                  name: recruit.name,
                  timePlace: recruit.timePlace ?? [],
                  position: position,
                  poster: recruit.poster,
                );
              }),
            );
            if (mounted) setState(() => participateCard = withRoles);
          } catch (_) {}
        })(),
      ]);
    }
  }

  void retryRecruit() {
    setState(() {
      recruitLoading = true;
      recruitFailed = false;
    });
    fetchHomeCards();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  List<String> get currentProfileContent {
    final profile = ref.read(profileProvider);
    return profile.hasData ? profile.profileContent : widget.profileContent;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final selectedMode = ref.watch(homeSelectedModeProvider);
    final savedProfile = ref.watch(profileProvider);
    final profileContent = savedProfile.hasData
        ? savedProfile.profileContent
        : widget.profileContent;
    final activeCards =
        selectedMode == '모집' ? recruitCard : participateCard;

    return BasicLayout(
      needTitleExpand: true,
      needWidget: [
        (widget.logo != null)
            ? Image.file(File(widget.logo!), cacheWidth: 300)
            : Container(),
      ],
      actions: [
        ElevatedButton.icon(
          onPressed: onActivitySearchButtonPressed,
          label: Text('활동 검색', style: TextStyle(fontSize: screenWidth * 0.036)),
          icon: Icon(Icons.search, size: screenWidth * 0.073),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(screenWidth * 0.547, 44),
            foregroundColor: appPrimaryColor,
            backgroundColor: Colors.white,
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
      body: RefreshIndicator(
        onRefresh: fetchHomeCards,
        color: appPrimaryColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileCardBasic(
                profileContent: profileContent,
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
                          ref.read(homeSelectedModeProvider.notifier).setMode(
                              mode);
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
                        onPressed: addActivity,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(10, 10),
                          fixedSize: Size(
                            screenWidth * 0.107,
                            screenWidth * 0.107,
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
              (selectedMode == '모집' && recruitLoading)
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : (selectedMode == '모집' &&
                        recruitFailed &&
                        recruitCard.isEmpty)
                  ? LoadFailedView(onRetry: retryRecruit)
                  : activeCards.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Center(
                        child: Text(
                          '$selectedMode중인 활동이 없습니다.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: screenWidth * 0.041,
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: activeCards
                            .map<Widget>(
                              (activity) => RepaintBoundary(
                                child: Container(
                                  width: screenWidth * 0.85,
                                  child: ActivityCardBasic(
                                    name: activity.name,
                                    timePlace: activity.timePlace,
                                    position: activity.position,
                                    poster: activity.poster,
                                    onTap: () => activityCardTap(activity),
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
              applyCard.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Center(
                        child: Text(
                          '신청한 활동이 없습니다.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: screenWidth * 0.041,
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: applyCard
                            .map(
                              (activity) => RepaintBoundary(
                                child: Container(
                                  width: screenWidth * 0.85,
                                  child: ActivityCardApply(
                                    name: activity.name,
                                    timePlace: activity.timePlace,
                                    applyStatus: activity.applyStatus,
                                    onProfileCheckPressed: () =>
                                        onProfileCheckPressed(activity),
                                    onDetailButtonPressed: () =>
                                        onDetailButtonPressed(activity),
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

  void onActivitySearchButtonPressed() {
    Navigator.pushNamed(
      context,
      PageRoutes.findActivity,
      arguments: {'activityList': <ActivityItem>[]},
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
              i < currentProfileContent.length ? currentProfileContent[i] : '',
        ),
        'introduction': '',
        'spec': '',
        'favorites': <String>['', '', ''],
      },
    );
  }

  void addActivity() {
    final selectedMode = ref.read(homeSelectedModeProvider);
    if (selectedMode == '모집') {
      Navigator.pushNamed(context, PageRoutes.activityRecruit);
    } else {
      Navigator.pushNamed(
        context,
        PageRoutes.findActivity,
        arguments: {'activityList': <ActivityItem>[]},
      );
    }
  }

  void activityCardTap(ActivityCardItem activity) {
    final selectedMode = ref.read(homeSelectedModeProvider);
    if (selectedMode == '모집') {
      Navigator.pushNamed(
        context,
        PageRoutes.activityInformation,
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
    } else {
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

  void onProfileCheckPressed(ApplyCardItem activity) {
    Navigator.pushNamed(
      context,
      PageRoutes.applyingActivity,
      arguments: {
        'activityName': activity.name,
        'profile': [activity.introduction, activity.spec],
        'poster': null,
        'applicationId': activity.applicationId,
        'partyId': activity.partyId,
      },
    );
  }

  void onDetailButtonPressed(ApplyCardItem activity) {
    Navigator.pushNamed(
      context,
      PageRoutes.activityInformation,
      arguments: {
        'activityName': activity.name,
        'activityOverview': '',
        'activityDetail': '',
        'leaderProfile': <String>[],
        'position': <String>[],
        'poster': null,
        'partyId': activity.partyId,
      },
    );
  }
}
