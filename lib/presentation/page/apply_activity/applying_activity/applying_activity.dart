import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import '../../future&component/component/when_to_meet.dart';
import '../../future&component/layout/basic_layout.dart';
import 'applying_activity_body1.dart';
import 'applying_activity_footer.dart';
import 'applying_activity_information.dart';

class ApplyingActivityNotifier
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

final applyingActivityProvider =
    NotifierProvider.autoDispose<
      ApplyingActivityNotifier,
      ({List<bool> editingMode, List<String> currentProfile})
    >(ApplyingActivityNotifier.new);

class ApplyingActivity extends ConsumerStatefulWidget {
  final String activityName;
  final List<String> profile;
  final String? poster;
  final int applicationId;
  const ApplyingActivity({
    super.key,
    required this.activityName,
    required this.profile,
    this.poster,
    this.applicationId = 0,
  });

  @override
  ConsumerState<ApplyingActivity> createState() => ApplyingActivityState();
}

class ApplyingActivityState extends ConsumerState<ApplyingActivity> {
  late final List<TextEditingController> bodyTextControllers = [];
  late final List<ScrollController> bodyScrollControllers = [];
  late TextEditingController timeTextController;
  late ScrollController whenToMeetScrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(applyingActivityProvider.notifier).init(widget.profile);
    });
    timeTextController = TextEditingController();
    whenToMeetScrollController = ScrollController();
    for (int i = 0; i < 4; i++) {
      if (i > 0 && i < 3) {
        bodyTextControllers.add(
          TextEditingController(
            text: widget.profile.length > (i - 1) ? widget.profile[i - 1] : '',
          ),
        );
      }
      bodyScrollControllers.add(ScrollController());
      if (bodyScrollControllers[0].hasClients) {
        bodyScrollControllers[0].jumpTo(0.0);
      }
    }
  }

  @override
  void dispose() {
    for (TextEditingController controller in bodyTextControllers) {
      controller.dispose();
    }
    for (ScrollController controller in bodyScrollControllers) {
      controller.dispose();
    }
    timeTextController.dispose();
    whenToMeetScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final activityState = ref.watch(applyingActivityProvider);
    return BasicLayout(
      title: '지원 중인 활동',
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: bodyScrollControllers[0],
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
                      child: ApplyingActivityInformation(
                        activityOverview: widget.activityName,
                        poster: widget.poster,
                        scrollController: bodyScrollControllers[0],
                      ),
                    ),
                    ApplyingActivityBody(
                      section: '소개',
                      content: activityState.currentProfile.isNotEmpty
                          ? activityState.currentProfile[0]
                          : '',
                      editingMode: activityState.editingMode[0],
                      onEditButtonPressed: () => onEditButtonPressed(0),
                      textController: bodyTextControllers[0],
                      scrollController: bodyScrollControllers[1],
                    ),
                    ApplyingActivityBody(
                      section: '스펙',
                      content: activityState.currentProfile.length > 1
                          ? activityState.currentProfile[1]
                          : '',
                      editingMode: activityState.editingMode[1],
                      onEditButtonPressed: () => onEditButtonPressed(1),
                      textController: bodyTextControllers[1],
                      scrollController: bodyScrollControllers[2],
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
                            fixedSize: Size(screenWidth * 0.146, 44),
                            side: const BorderSide(width: 0.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(
                                screenWidth * 0.024,
                              ),
                            ),
                            backgroundColor: activityState.editingMode[2]
                                ? appPrimaryColor
                                : const Color(0xff1cb879),
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            activityState.editingMode[2] ? '저장' : '수정',
                            style: TextStyle(
                              fontSize: screenWidth * 0.041,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 23),
                      child: SizedBox(
                        height: 704,
                        child: WhenToMeet(
                          readOnly: !activityState.editingMode[2],
                          scrollController: bodyScrollControllers[3],
                          timeTextController: timeTextController,
                          whenToMeetScrollController: whenToMeetScrollController,
                        ),
                      ),
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
            child: ApplyingActivityFooter(
              onApplyCancelButtonPressed: onApplyCancelButtonPressed,
              onApplyListButtonPressed: onApplyListButtonPressed,
            ),
          ),
        ],
      ),
      bottomNavigationBar: false,
    );
  }

  Future<void> onApplyCancelButtonPressed() async {
    final userId = ref.read(currentUserProvider);
    if (userId != null && widget.applicationId != 0) {
      try {
        await ref
            .read(applyRepositoryProvider)
            .deleteApply(widget.applicationId.toString(), userId);
      } catch (_) {}
    }
    if (mounted) Navigator.pop(context);
  }

  void onApplyListButtonPressed() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      PageRoutes.applyList,
      (route) => false,
    );
  }

  void onEditButtonPressed(int i) {
    final wasEditing = ref.read(applyingActivityProvider).editingMode[i];
    final textContent = i < bodyTextControllers.length
        ? bodyTextControllers[i].text
        : '';
    ref.read(applyingActivityProvider.notifier).toggleEdit(i, textContent);
    if (wasEditing && i == 0 && widget.applicationId != 0) {
      ref
          .read(applyRepositoryProvider)
          .putApplication(widget.applicationId, introduction: textContent.trim())
          .catchError((_) {});
    }
    if (wasEditing && i < 2) {
      if (bodyScrollControllers[i + 1].hasClients) {
        bodyScrollControllers[i + 1].jumpTo(0.0);
      }
    }
  }
}
