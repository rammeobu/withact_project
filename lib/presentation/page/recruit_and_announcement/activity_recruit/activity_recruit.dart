import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/data/models/recruit_data_structures.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/activity_recruit/activity_recruit_body2.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/activity_recruit/activity_recruit_body3.dart';
import '../../future&component/layout/basic_layout.dart';
import 'activity_recruit_body.dart';
import 'activity_recruit_footer.dart';

class ActivityRecruitNotifier
    extends Notifier<
      ({List<String> preferences, List<String> positions, List<int> counts})
    > {
  @override
  ({List<String> preferences, List<String> positions, List<int> counts})
  build() => (preferences: [], positions: [''], counts: [1]);

  void addPreference(String text) {
    state = (
      preferences: [...state.preferences, text],
      positions: state.positions,
      counts: state.counts,
    );
  }

  void removePreference(int i) {
    final newPrefs = List<String>.from(state.preferences)..removeAt(i);
    state = (
      preferences: newPrefs,
      positions: state.positions,
      counts: state.counts,
    );
  }

  void addPosition() {
    state = (
      preferences: state.preferences,
      positions: [...state.positions, ''],
      counts: [...state.counts, 1],
    );
  }

  void removePosition(int i) {
    final newPositions = List<String>.from(state.positions)..removeAt(i);
    final newCounts = List<int>.from(state.counts)..removeAt(i);
    state = (
      preferences: state.preferences,
      positions: newPositions,
      counts: newCounts,
    );
  }

  void incrementCount(int i) {
    final newCounts = List<int>.from(state.counts);
    newCounts[i] = newCounts[i] + 1;
    state = (
      preferences: state.preferences,
      positions: state.positions,
      counts: newCounts,
    );
  }

  void decrementCount(int i) {
    final newCounts = List<int>.from(state.counts);
    if (newCounts[i] > 1) newCounts[i] = newCounts[i] - 1;
    state = (
      preferences: state.preferences,
      positions: state.positions,
      counts: newCounts,
    );
  }
}

final activityRecruitProvider =
    NotifierProvider.autoDispose<
      ActivityRecruitNotifier,
      ({List<String> preferences, List<String> positions, List<int> counts})
    >(ActivityRecruitNotifier.new);

class ActivityRecruit extends ConsumerStatefulWidget {
  final List<String>? profile;
  const ActivityRecruit({super.key, this.profile});

  @override
  ConsumerState<ActivityRecruit> createState() => ActivityRecruitState();
}

class ActivityRecruitState extends ConsumerState<ActivityRecruit> {
  late List<ScrollController> scrollControllers;
  late List<TextEditingController> staticTextControllers;
  late List<TextEditingController> dynamicTextControllers;
  int? selectedActivityId;

  @override
  void initState() {
    super.initState();
    scrollControllers = List.generate(3, (i) => ScrollController());
    staticTextControllers = List.generate(3, (i) => TextEditingController());
    dynamicTextControllers = [TextEditingController()];
  }

  @override
  void dispose() {
    for (var controller in scrollControllers) {
      controller.dispose();
    }
    for (var controller in staticTextControllers) {
      controller.dispose();
    }
    for (var controller in dynamicTextControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final recruitState = ref.watch(activityRecruitProvider);
    return BasicLayout(
      title: '대외활동 모집',
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: scrollControllers[0],
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.036,
                  top: 13,
                  right: screenWidth * 0.036,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ActivityRecruitBody(
                      section: '활동 이름',
                      textEditingController: staticTextControllers[0],
                      onSearchButtonPressed: onSearchButtonPressed,
                      isRequired: true,
                    ),
                    ActivityRecruitBody(
                      section: '파티 이름/소개',
                      textEditingController: staticTextControllers[1],
                      isRequired: true,
                    ),
                    ActivityRecruitBody2(
                      preferences: recruitState.preferences,
                      scrollController: scrollControllers[1],
                      textEditingController: staticTextControllers[2],
                      onPreferenceAdded: onPreferenceSubmitted,
                      onDeletePreferenceButtonPressed: (i) =>
                          onDeletePreferenceButtonPressed(i),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 23)),
                    ActivityRecruitBody3(
                      positions: recruitState.positions,
                      counts: recruitState.counts,
                      textEditingControllers: dynamicTextControllers,
                      primaryScrollController: scrollControllers[0],
                      horizontalScrollController: scrollControllers[2],
                      onAddPositionButtonPressed: onAddPositionButtonPressed,
                      onDeletePositionButtonPressed: (i) =>
                          onDeletePositionButtonPressed(i),
                      onIncrementCountButtonPressed: (i) =>
                          ref
                              .read(activityRecruitProvider.notifier)
                              .incrementCount(i),
                      onDecrementCountButtonPressed: (i) =>
                          ref
                              .read(activityRecruitProvider.notifier)
                              .decrementCount(i),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.036,
              vertical: 12,
            ),
            child: ActivityRecruitFooter(
              onRecruitStartButtonPressed: onRecruitStartButtonPressed,
            ),
          ),
        ],
      ),
      bottomNavigationBar: false,
    );
  }

  Future<void> onSearchButtonPressed() async {
    final selected = await Navigator.pushNamed(
      context,
      PageRoutes.findActivity,
      arguments: {'selectMode': true},
    );
    if (selected is Map && mounted) {
      staticTextControllers[0].text = selected['activityName'] as String? ?? '';
      selectedActivityId = selected['id'] as int?;
    }
  }

  bool isSubmitting = false;

  void onRecruitStartButtonPressed() {
    if (isSubmitting) return;
    if (staticTextControllers[0].text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('활동 이름을 입력해 주세요.')));
      return;
    }
    if (staticTextControllers[1].text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('파티 이름/소개를 입력해 주세요.')));
      return;
    }
    if (dynamicTextControllers.isEmpty ||
        dynamicTextControllers.every(
          (controller) => controller.text.trim().isEmpty,
        )) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('모집 역할을 최소 하나 이상 입력해 주세요.')),
        );
      return;
    }
    if (!ref.read(loggedInProvider)) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('로그인이 필요합니다.')));
      return;
    }
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        content: const Text('모집을 시작하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              setState(() => isSubmitting = true);
              HapticFeedback.lightImpact();
              bool succeeded = false;
              try {
                final roleNames = <String>[];
                final roleCounts = <int>[];
                final stepperCounts =
                    ref.read(activityRecruitProvider).counts;
                for (int i = 0; i < dynamicTextControllers.length; i++) {
                  final roleName = dynamicTextControllers[i].text.trim();
                  if (roleName.isEmpty) continue;
                  roleNames.add(roleName);
                  roleCounts.add(
                    i < stepperCounts.length ? stepperCounts[i] : 1,
                  );
                }
                await ref.read(recruitRepositoryProvider).postActivity(
                  ActivityRecruitDataStructure(
                    activityId: selectedActivityId,
                    partyIntroduction: staticTextControllers[1].text.trim(),
                    preferences: ref.read(activityRecruitProvider).preferences,
                    roleNames: roleNames,
                    roleCounts: roleCounts,
                    leaderId: ref.read(currentUserProvider),
                  ),
                );
                succeeded = true;
              } catch (_) {
              } finally {
                if (mounted) setState(() => isSubmitting = false);
              }
              if (mounted) {
                Navigator.pushNamed(
                  context,
                  succeeded ? PageRoutes.recruitSuccess : PageRoutes.recruitFail,
                );
              }
            },
            child: const Text('예'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('아니오'),
          ),
        ],
      ),
    );
  }

  void onPreferenceSubmitted(String text) {
    ref.read(activityRecruitProvider.notifier).addPreference(text);
    staticTextControllers[2].clear();

    Future.delayed(const Duration(milliseconds: 75), () {
      if (!mounted) return;
      if (scrollControllers[1].hasClients) {
        scrollControllers[1].animateTo(
          scrollControllers[1].position.maxScrollExtent,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void onDeletePreferenceButtonPressed(int i) {
    double currentOffset = scrollControllers[1].hasClients
        ? scrollControllers[1].offset
        : 0.0;
    ref.read(activityRecruitProvider.notifier).removePreference(i);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 50));
      if (!mounted) return;
      if (scrollControllers[1].hasClients) {
        scrollControllers[1].jumpTo(currentOffset);
        scrollControllers[1].animateTo(
          scrollControllers[1].position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void onAddPositionButtonPressed() {
    ref.read(activityRecruitProvider.notifier).addPosition();
    dynamicTextControllers.add(TextEditingController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollControllers[0].hasClients) {
        scrollControllers[0].animateTo(
          scrollControllers[0].position.maxScrollExtent,
          duration: const Duration(milliseconds: 50),
          curve: Curves.easeOut,
        );
      }
      if (scrollControllers[2].hasClients) {
        scrollControllers[2].animateTo(
          scrollControllers[2].position.maxScrollExtent,
          duration: const Duration(milliseconds: 50),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void onDeletePositionButtonPressed(int i) {
    double currentHorizontalOffset = scrollControllers[2].hasClients
        ? scrollControllers[2].offset
        : 0.0;

    ref.read(activityRecruitProvider.notifier).removePosition(i);
    dynamicTextControllers[i].dispose();
    dynamicTextControllers.removeAt(i);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 10));
      if (!mounted) return;

      if (ref.read(activityRecruitProvider).positions.isEmpty) {
        if (scrollControllers[0].hasClients) {
          scrollControllers[0].animateTo(
            scrollControllers[0].position.maxScrollExtent,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        }
      }

      if (scrollControllers[2].hasClients) {
        scrollControllers[2].jumpTo(currentHorizontalOffset);
        scrollControllers[2].animateTo(
          scrollControllers[2].position.maxScrollExtent,
          duration: const Duration(milliseconds: 50),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
