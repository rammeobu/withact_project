import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/work_recruit/work_recruit_body2.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/work_recruit/work_recruit_body3.dart';
import '../../future&component/layout/basic_layout.dart';
import 'work_recruit_body.dart';
import 'work_recruit_footer.dart';

class WorkRecruitNotifier
    extends Notifier<({List<String> preferences, List<String> positions})> {
  @override
  ({List<String> preferences, List<String> positions}) build() =>
      (preferences: [], positions: ['']);

  void addPreference(String text) {
    state = (
      preferences: [...state.preferences, text],
      positions: state.positions,
    );
  }

  void removePreference(int i) {
    final newPrefs = List<String>.from(state.preferences)..removeAt(i);
    state = (preferences: newPrefs, positions: state.positions);
  }

  void addPosition() {
    state = (
      preferences: state.preferences,
      positions: [...state.positions, ''],
    );
  }

  void removePosition(int i) {
    final newPositions = List<String>.from(state.positions)..removeAt(i);
    state = (preferences: state.preferences, positions: newPositions);
  }
}

final workRecruitProvider =
    NotifierProvider.autoDispose<
      WorkRecruitNotifier,
      ({List<String> preferences, List<String> positions})
    >(WorkRecruitNotifier.new);

class WorkRecruit extends ConsumerStatefulWidget {
  final List<String>? profile;
  const WorkRecruit({super.key, this.profile});

  @override
  ConsumerState<WorkRecruit> createState() => _WorkRecruitState();
}

class _WorkRecruitState extends ConsumerState<WorkRecruit> {
  late List<ScrollController> scrollControllers;
  late List<TextEditingController> staticTextControllers;
  late List<TextEditingController> dynamicTextControllers;

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
    final recruitState = ref.watch(workRecruitProvider);
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
                    WorkRecruitBody(
                      section: '활동 이름',
                      textEditingController: staticTextControllers[0],
                      onSearchButtonPressed: onSearchButtonPressed,
                      isRequired: true,
                    ),
                    WorkRecruitBody(
                      section: '파티 이름/소개',
                      textEditingController: staticTextControllers[1],
                      isRequired: true,
                    ),
                    WorkRecruitBody2(
                      preferences: recruitState.preferences,
                      scrollController: scrollControllers[1],
                      textEditingController: staticTextControllers[2],
                      onPreferenceAdded: onPreferenceSubmitted,
                      onDeletePreferenceButtonPressed: (i) =>
                          onDeletePreferenceButtonPressed(i),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 23)),
                    WorkRecruitBody3(
                      positions: recruitState.positions,
                      textEditingControllers: dynamicTextControllers,
                      primaryScrollController: scrollControllers[0],
                      horizontalScrollController: scrollControllers[2],
                      onAddPositionButtonPressed: onAddPositionButtonPressed,
                      onDeletePositionButtonPressed: (i) =>
                          onDeletePositionButtonPressed(i),
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
            child: WorkRecruitFooter(
              onRecruitStartButtonPressed: onRecruitStartButtonPressed,
            ),
          ),
        ],
      ),
      bottomNavigationBar: false,
    );
  }

  void onSearchButtonPressed() {
    Navigator.pushNamed(context, PageRoutes.findWork);
  }

  void onRecruitStartButtonPressed() {
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('모집을 시작하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              const bool succeeded = true;
              Navigator.pushNamed(
                context,
                succeeded ? PageRoutes.recruitSuccess : PageRoutes.recruitFail,
              );
            },
            child: const Text('예'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('아니오'),
          ),
        ],
      ),
    );
  }

  void onPreferenceSubmitted(String text) {
    ref.read(workRecruitProvider.notifier).addPreference(text);
    staticTextControllers[2].clear();

    Future.delayed(const Duration(milliseconds: 75), () {
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
    ref.read(workRecruitProvider.notifier).removePreference(i);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 50));
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
    ref.read(workRecruitProvider.notifier).addPosition();
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

    ref.read(workRecruitProvider.notifier).removePosition(i);
    dynamicTextControllers[i].dispose();
    dynamicTextControllers.removeAt(i);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 10));

      if (ref.read(workRecruitProvider).positions.isEmpty) {
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
