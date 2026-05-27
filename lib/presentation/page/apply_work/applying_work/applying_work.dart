import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import '../../future&component/component/when_to_meet.dart';
import '../../future&component/layout/basic_layout.dart';
import 'applying_work_body1.dart';
import 'applying_work_footer.dart';
import 'applying_work_information.dart';

class ApplyingWorkNotifier
    extends Notifier<({List<bool> editingMode, List<String> currentProfile})> {
  @override
  ({List<bool> editingMode, List<String> currentProfile}) build() =>
      (editingMode: [false, false, false], currentProfile: []);

  void init(List<String> profile) {
    state = (
      editingMode: [false, false, false],
      currentProfile: List.from(profile),
    );
  }

  void toggleEdit(int i, String updatedContent) {
    final newMode = List<bool>.from(state.editingMode);
    final newProfile = List<String>.from(state.currentProfile);
    if (newMode[i] && i < 2) {
      while (newProfile.length <= i) newProfile.add('');
      newProfile[i] = updatedContent;
    }
    newMode[i] = !newMode[i];
    state = (editingMode: newMode, currentProfile: newProfile);
  }
}

final applyingWorkProvider =
    NotifierProvider.autoDispose<
      ApplyingWorkNotifier,
      ({List<bool> editingMode, List<String> currentProfile})
    >(ApplyingWorkNotifier.new);

class ApplyingWork extends ConsumerStatefulWidget {
  final String workName;
  final List<String> profile;
  final String? poster;
  const ApplyingWork({
    super.key,
    required this.workName,
    required this.profile,
    this.poster,
  });

  @override
  ConsumerState<ApplyingWork> createState() => _ApplyingWorkState();
}

class _ApplyingWorkState extends ConsumerState<ApplyingWork> {
  late final List<TextEditingController> _bodyTextControllers = [];
  late final List<ScrollController> _bodyScrollControllers = [];
  late TextEditingController timeTextController;
  late ScrollController whenToMeetScrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(applyingWorkProvider.notifier).init(widget.profile);
    });
    for (int i = 0; i < 4; i++) {
      if (i > 0 && i < 3) {
        _bodyTextControllers.add(
          TextEditingController(
            text: widget.profile.length > (i - 1) ? widget.profile[i - 1] : '',
          ),
        );
      }
      _bodyScrollControllers.add(ScrollController());
      if (_bodyScrollControllers[0].hasClients) {
        _bodyScrollControllers[0].jumpTo(0.0);
      }
      timeTextController = TextEditingController();
      whenToMeetScrollController = ScrollController();
    }
  }

  @override
  void dispose() {
    for (TextEditingController controller in _bodyTextControllers) {
      controller.dispose();
    }
    for (ScrollController controller in _bodyScrollControllers) {
      controller.dispose();
    }
    timeTextController.dispose();
    whenToMeetScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final workState = ref.watch(applyingWorkProvider);
    return BasicLayout(
      title: '지원 중인 활동',
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _bodyScrollControllers[0],
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.036,
                  top: 13,
                  right: screenWidth * 0.036,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: ApplyingWorkInformation(
                        workOverview: widget.workName,
                        poster: widget.poster,
                        scrollController: _bodyScrollControllers[0],
                      ),
                    ),
                    ApplyingWorkBody(
                      section: '소개',
                      content: workState.currentProfile.isNotEmpty
                          ? workState.currentProfile[0]
                          : '',
                      editingMode: workState.editingMode[0],
                      onEditButtonPressed: () => onEditButtonPressed(0),
                      textController: _bodyTextControllers[0],
                      scrollController: _bodyScrollControllers[1],
                    ),
                    ApplyingWorkBody(
                      section: '스펙',
                      content: workState.currentProfile.length > 1
                          ? workState.currentProfile[1]
                          : '',
                      editingMode: workState.editingMode[1],
                      onEditButtonPressed: () => onEditButtonPressed(1),
                      textController: _bodyTextControllers[1],
                      scrollController: _bodyScrollControllers[2],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            '활동 가능 시간',
                            style: TextStyle(
                              fontSize: screenWidth * 0.058,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () => onEditButtonPressed(2),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            fixedSize: Size(screenWidth * 0.146, 41),
                            side: const BorderSide(width: 0.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(
                                screenWidth * 0.024,
                              ),
                            ),
                            backgroundColor: workState.editingMode[2]
                                ? appPrimaryColor
                                : const Color(0xff1cb879),
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            workState.editingMode[2] ? '저장' : '수정',
                            style: TextStyle(
                              fontSize: screenWidth * 0.041,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 704,
                      child: WhenToMeet(
                        readOnly: !workState.editingMode[2],
                        scrollController: _bodyScrollControllers[3],
                        timeTextController: timeTextController,
                        whenToMeetScrollController: whenToMeetScrollController,
                      ),
                    ),
                    const SizedBox(height: 23),
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
            child: ApplyingWorkFooter(
              onApplyCancelButtonPressed: onApplyCancelButtonPressed,
              onApplyListButtonPressed: onApplyListButtonPressed,
            ),
          ),
        ],
      ),
      bottomNavigationBar: false,
    );
  }

  void onApplyCancelButtonPressed() {
    Navigator.pop(context);
  }

  void onApplyListButtonPressed() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      PageRoutes.applyList,
      (route) => false,
    );
  }

  void onEditButtonPressed(int i) {
    final wasEditing = ref.read(applyingWorkProvider).editingMode[i];
    final textContent = i < _bodyTextControllers.length
        ? _bodyTextControllers[i].text
        : '';
    ref.read(applyingWorkProvider.notifier).toggleEdit(i, textContent);
    if (wasEditing && i < 2) {
      if (_bodyScrollControllers[i + 1].hasClients) {
        _bodyScrollControllers[i + 1].jumpTo(0.0);
      }
    }
  }
}
