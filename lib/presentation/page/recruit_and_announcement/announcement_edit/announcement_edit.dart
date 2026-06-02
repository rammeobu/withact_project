import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/announcement_edit/announcement_edit_body.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/announcement_edit/announcement_edit_body2.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/announcement_edit/announcement_edit_body3.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/announcement_edit/announcement_edit_footer.dart';
import '../../../../app.dart';
import '../../future&component/layout/basic_layout.dart';

class AnnouncementEditNotifier
    extends Notifier<({List<String> preference, List<String> position})> {
  @override
  ({List<String> preference, List<String> position}) build() =>
      (preference: [], position: []);

  void init({
    required List<String> preferences,
    required List<String> positions,
  }) {
    state = (
      preference: List.from(preferences),
      position: List.from(positions),
    );
  }

  void addPreference(String text) {
    state = (preference: [...state.preference, text], position: state.position);
  }

  void removePreference(int i) {
    final newPrefs = List<String>.from(state.preference)..removeAt(i);
    state = (preference: newPrefs, position: state.position);
  }

  void addPosition() {
    state = (preference: state.preference, position: [...state.position, '']);
  }

  void removePosition(int i) {
    final newPositions = List<String>.from(state.position)..removeAt(i);
    state = (preference: state.preference, position: newPositions);
  }
}

final announcementEditProvider =
    NotifierProvider.autoDispose<
      AnnouncementEditNotifier,
      ({List<String> preference, List<String> position})
    >(AnnouncementEditNotifier.new);

class AnnouncementEdit extends ConsumerStatefulWidget {
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
  ConsumerState<AnnouncementEdit> createState() => _AnnouncementEditState();
}

class _AnnouncementEditState extends ConsumerState<AnnouncementEdit> {
  late List<ScrollController> scrollControllers;
  late List<TextEditingController> staticTextControllers;
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(announcementEditProvider.notifier)
          .init(
            preferences: widget.preferences ?? [],
            positions: widget.positions,
          );
    });

    dynamicTextControllers = List.generate(
      widget.positions.length,
      (i) => TextEditingController(text: widget.positions[i]),
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final editState = ref.watch(announcementEditProvider);
    return BasicLayout(
      title: '공고 편집',
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
                    AnnouncementEditBody(
                      section: '활동 이름',
                      textEditingController: staticTextControllers[0],
                      onSearchButtonPressed: onSearchButtonPressed,
                      content: widget.workName,
                      isRequired: true,
                    ),
                    AnnouncementEditBody(
                      section: '파티 이름/소개',
                      textEditingController: staticTextControllers[1],
                      content: widget.partyNameIntroduction,
                      isRequired: true,
                    ),
                    AnnouncementEditBody2(
                      preferences: editState.preference,
                      scrollController: scrollControllers[1],
                      textEditingController: staticTextControllers[2],
                      onPreferenceAdded: onPreferenceAdded,
                      onDeletePreferenceButtonPressed: (i) =>
                          onDeletePreferenceButtonPressed(i),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 23)),
                    AnnouncementEditBody3(
                      positions: editState.position,
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
            child: AnnouncementEditFooter(
              onSaveAndExitButtonPressed: onSaveAndExitButtonPressed,
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

  void onSaveAndExitButtonPressed() {
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
    final editState = ref.read(announcementEditProvider);
    if (editState.position.isEmpty ||
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
    Navigator.pop(context);
  }

  void onPreferenceAdded(String text) {
    ref.read(announcementEditProvider.notifier).addPreference(text);
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
    ref.read(announcementEditProvider.notifier).removePreference(i);

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
    ref.read(announcementEditProvider.notifier).addPosition();
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

    ref.read(announcementEditProvider.notifier).removePosition(i);
    dynamicTextControllers[i].dispose();
    dynamicTextControllers.removeAt(i);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 10));
      if (!mounted) return;

      if (ref.read(announcementEditProvider).position.isEmpty) {
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
