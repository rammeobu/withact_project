import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/announcement_edit/announcement_edit_body.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/announcement_edit/announcement_edit_body2.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/announcement_edit/announcement_edit_body3.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/announcement_edit/announcement_edit_footer.dart';
import '../../future&component/layout/basic_layout.dart';

class AnnouncementEdit extends StatefulWidget {
  final String workName;
  final String partyNameIntroduction;
  final List<String>? preferences;
  final List<String> positions;
  const AnnouncementEdit({
    super.key,
    required this.workName,
    required this.partyNameIntroduction,
    this.preferences,
    required this.positions,
  });

  @override
  State<AnnouncementEdit> createState() => _AnnouncementEditState();
}

class _AnnouncementEditState extends State<AnnouncementEdit> {
  late List<ScrollController> scrollControllers;
  late List<TextEditingController> staticTextControllers;

  late List<String> preference;
  late List<String> position;
  late List<TextEditingController> dynamicTextControllers;

  @override
  void initState() {
    super.initState();

    scrollControllers = List.generate(3, (i) => ScrollController());

    staticTextControllers = [
      TextEditingController(text: widget.workName),
      TextEditingController(text: widget.partyNameIntroduction),
      TextEditingController(),
    ];

    preference = List.from(widget.preferences ?? []);
    position = List.from(widget.positions);

    dynamicTextControllers = List.generate(
      position.length,
      (i) => TextEditingController(text: position[i]),
    );
  }

  @override
  void dispose() {
    for (ScrollController controller in scrollControllers) {
      controller.dispose();
    }
    for (TextEditingController controller in staticTextControllers) {
      controller.dispose();
    }
    for (TextEditingController controller in dynamicTextControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasicLayout(
      title: '공고 편집',
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
                    AnnouncementEditBody(
                      section: '활동 이름',
                      textEditingController: staticTextControllers[0],
                      onSearchButtonPressed: onSearchButtonPressed,
                      content: widget.workName,
                    ),
                    AnnouncementEditBody(
                      section: '파티 이름/소개',
                      textEditingController: staticTextControllers[1],
                      content: widget.partyNameIntroduction,
                    ),
                    AnnouncementEditBody2(
                      preferences: preference,
                      scrollController: scrollControllers[1],
                      textEditingController: staticTextControllers[2],
                      onPreferenceAdded: onPreferenceAdded,
                      onDeletePreferenceButtonPressed: (i) =>
                          onDeletePreferenceButtonPressed(i),
                    ),
                    const SizedBox(height: 20.0),
                    AnnouncementEditBody3(
                      positions: position,
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
            child: AnnouncementEditFooter(
              onSaveAndExitButtonPressed: onSaveAndExitButtonPressed,
            ),
          ),
        ],
      ),
      bottomNavigationBar: false,
    );
  }

  void onSearchButtonPressed() {}

  void onSaveAndExitButtonPressed() {}

  void onPreferenceAdded(String text) {
    setState(() {
      preference.add(text);
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
      preference.removeAt(i);
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
      position.add('');
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
      position.removeAt(i);
      dynamicTextControllers[i].dispose();
      dynamicTextControllers.removeAt(i);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 10));

      if (position.isEmpty) {
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
