import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/announcement_edit/announcement_edit_body.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/announcement_edit/announcement_edit_body2.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/announcement_edit/announcement_edit_body3.dart';
import 'package:party_maker/presentation/page/recruit_and_announcement/announcement_edit/announcement_edit_footer.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import '../../../../app.dart';
import '../../future&component/layout/basic_layout.dart';

typedef AnnouncementEditData = ({
  List<String> preference,
  List<String> position,
  List<int> count,
  List<int?> roleId,
});

class AnnouncementEditNotifier extends Notifier<AnnouncementEditData> {
  @override
  AnnouncementEditData build() =>
      (preference: [], position: [], count: [], roleId: []);

  void init({
    required List<String> preferences,
    required List<String> positions,
    List<int>? counts,
    List<int?>? roleIds,
  }) {
    state = (
      preference: List.from(preferences),
      position: List.from(positions),
      count: counts != null && counts.length == positions.length
          ? List.from(counts)
          : List.filled(positions.length, 1),
      roleId: roleIds != null && roleIds.length == positions.length
          ? List.from(roleIds)
          : List.filled(positions.length, null),
    );
  }

  void addPreference(String text) {
    state = (
      preference: [...state.preference, text],
      position: state.position,
      count: state.count,
      roleId: state.roleId,
    );
  }

  void removePreference(int i) {
    final newPrefs = List<String>.from(state.preference)..removeAt(i);
    state = (
      preference: newPrefs,
      position: state.position,
      count: state.count,
      roleId: state.roleId,
    );
  }

  void addPosition() {
    state = (
      preference: state.preference,
      position: [...state.position, ''],
      count: [...state.count, 1],
      roleId: [...state.roleId, null],
    );
  }

  void removePosition(int i) {
    final newPositions = List<String>.from(state.position)..removeAt(i);
    final newCounts = List<int>.from(state.count)..removeAt(i);
    final newRoleIds = List<int?>.from(state.roleId)..removeAt(i);
    state = (
      preference: state.preference,
      position: newPositions,
      count: newCounts,
      roleId: newRoleIds,
    );
  }

  void incrementCount(int i) {
    if (i >= state.count.length) return;
    final newCounts = List<int>.from(state.count);
    newCounts[i] = newCounts[i] + 1;
    state = (
      preference: state.preference,
      position: state.position,
      count: newCounts,
      roleId: state.roleId,
    );
  }

  void decrementCount(int i) {
    if (i >= state.count.length || state.count[i] <= 1) return;
    final newCounts = List<int>.from(state.count);
    newCounts[i] = newCounts[i] - 1;
    state = (
      preference: state.preference,
      position: state.position,
      count: newCounts,
      roleId: state.roleId,
    );
  }
}

final announcementEditProvider =
    NotifierProvider.autoDispose<AnnouncementEditNotifier, AnnouncementEditData>(
      AnnouncementEditNotifier.new,
    );

class AnnouncementEdit extends ConsumerStatefulWidget {
  final String activityName;
  final String partyNameIntroduction;
  final List<String>? preferences;
  final List<String> positions;
  final int partyId;
  const AnnouncementEdit({
    super.key,
    required this.activityName,
    required this.partyNameIntroduction,
    this.preferences,
    required this.positions,
    this.partyId = 0,
  });

  @override
  ConsumerState<AnnouncementEdit> createState() => AnnouncementEditState();
}

class AnnouncementEditState extends ConsumerState<AnnouncementEdit> {
  late List<ScrollController> scrollControllers;
  late List<TextEditingController> staticTextControllers;
  late List<TextEditingController> dynamicTextControllers;

  @override
  void initState() {
    super.initState();

    scrollControllers = List.generate(3, (i) => ScrollController());

    staticTextControllers = [
      TextEditingController(text: widget.activityName),
      TextEditingController(text: widget.partyNameIntroduction),
      TextEditingController(),
    ];

    dynamicTextControllers = List.generate(
      widget.positions.length,
      (i) => TextEditingController(text: widget.positions[i]),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => fetchRoles());
  }

  Future<void> fetchRoles() async {
    final notifier = ref.read(announcementEditProvider.notifier);
    if (widget.partyId == 0) {
      notifier.init(
        preferences: widget.preferences ?? [],
        positions: widget.positions,
      );
      return;
    }
    try {
      final roles = await ref
          .read(findRepositoryProvider)
          .getPartyRoles(widget.partyId);
      if (!mounted) return;
      if (roles.isNotEmpty) {
        for (final controller in dynamicTextControllers) {
          controller.dispose();
        }
        dynamicTextControllers = roles
            .map((role) => TextEditingController(text: role.roleName))
            .toList();
        notifier.init(
          preferences: widget.preferences ?? [],
          positions: roles.map((role) => role.roleName).toList(),
          counts: roles.map((role) => role.targetCount).toList(),
          roleIds: roles.map<int?>((role) => role.id).toList(),
        );
        setState(() {});
      } else {
        notifier.init(
          preferences: widget.preferences ?? [],
          positions: widget.positions,
        );
      }
    } catch (_) {
      if (mounted) {
        notifier.init(
          preferences: widget.preferences ?? [],
          positions: widget.positions,
        );
      }
    }
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
                      content: widget.activityName,
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
                      counts: editState.count,
                      textEditingControllers: dynamicTextControllers,
                      primaryScrollController: scrollControllers[0],
                      horizontalScrollController: scrollControllers[2],
                      onAddPositionButtonPressed: onAddPositionButtonPressed,
                      onDeletePositionButtonPressed: (i) =>
                          onDeletePositionButtonPressed(i),
                      onIncrementCountButtonPressed: (i) => ref
                          .read(announcementEditProvider.notifier)
                          .incrementCount(i),
                      onDecrementCountButtonPressed: (i) => ref
                          .read(announcementEditProvider.notifier)
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
            child: AnnouncementEditFooter(
              onSaveAndExitButtonPressed: onSaveAndExitButtonPressed,
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
    }
  }

  Future<void> onSaveAndExitButtonPressed() async {
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
    final recruitRepo = ref.read(recruitRepositoryProvider);
    try {
      await recruitRepo.putAnnouncement(
        widget.partyId,
        staticTextControllers[1].text.trim(),
      );
      // 기존 역할의 인원 수 변경 반영 (PATCH /roles/{roleId}?targetCount=)
      if (widget.partyId != 0) {
        for (int i = 0; i < editState.roleId.length; i++) {
          final roleId = editState.roleId[i];
          if (roleId != null) {
            try {
              await recruitRepo.updateRoleCount(
                widget.partyId,
                roleId,
                editState.count[i],
              );
            } catch (_) {}
          }
        }
      }
    } catch (_) {}
    if (mounted) Navigator.pop(context);
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
