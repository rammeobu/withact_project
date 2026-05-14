import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/work_recruit/work_recruit_body2.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/work_recruit/work_recruit_body3.dart';
import '../../future&component/layout/basic_layout.dart';
import 'work_recruit_body.dart';
import 'work_recruit_footer.dart';

class WorkRecruit extends StatefulWidget {
  final List<String>? profile;
  const WorkRecruit({super.key, this.profile});

  @override
  State<WorkRecruit> createState() => _WorkRecruitState();
}

class _WorkRecruitState extends State<WorkRecruit> {
  late List<ScrollController> scrollControllers;
  late List<TextEditingController> staticTextControllers;
  late List<String> preferences;
  late List<String> positions;
  late List<TextEditingController> dynamicTextControllers;

  @override
  void initState() {
    super.initState();

    scrollControllers = List.generate(3, (i) => ScrollController());
    staticTextControllers = List.generate(3, (i) => TextEditingController());
    preferences = [];
    positions = [''];
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
    return BasicLayout(
      title: '대외활동 모집',
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: scrollControllers[0],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WorkRecruitBody(
                      section: '활동 이름',
                      textEditingController: staticTextControllers[0],
                      onSearchButtonPressed: onSearchButtonPressed,
                    ),
                    WorkRecruitBody(
                      section: '파티 이름/소개',
                      textEditingController: staticTextControllers[1],
                    ),
                    WorkRecruitBody2(
                      preferences: preferences,
                      scrollController: scrollControllers[1],
                      textEditingController: staticTextControllers[2],
                      onPreferenceAdded: onPreferenceSubmitted,
                      onDeletePreferenceButtonPressed: (i) =>
                          onDeletePreferenceButtonPressed(i),
                    ),
                    const SizedBox(height: 20.0),
                    WorkRecruitBody3(
                      positions: positions,
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
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
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

  void onSearchButtonPressed() {}

  void onRecruitStartButtonPressed() {}

  void onPreferenceSubmitted(String text) {
    setState(() {
      preferences.add(text);
    });
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
    double currentOffset = scrollControllers[1].offset;
    setState(() {
      preferences.removeAt(i);
    });

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
    setState(() {
      positions.add('');
      dynamicTextControllers.add(TextEditingController());
    });

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

    setState(() {
      positions.removeAt(i);
      dynamicTextControllers[i].dispose();
      dynamicTextControllers.removeAt(i);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 10));

      if (positions.isEmpty) {
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
