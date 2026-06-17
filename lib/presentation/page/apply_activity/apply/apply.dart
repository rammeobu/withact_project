import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/find_data_structures.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import '../../future&component/component/when_to_meet.dart';
import '../../future&component/layout/basic_layout.dart';
import 'apply_body1.dart';
import 'apply_footer.dart';
import 'apply_information.dart';

class Apply extends ConsumerStatefulWidget {
  final String activityName;
  final List<String>? profile;
  final String? poster;
  final int? partyId;
  final int? roleId;
  final int? activityId;
  const Apply({
    super.key,
    required this.activityName,
    this.profile,
    this.poster,
    this.partyId,
    this.roleId,
    this.activityId,
  });

  @override
  ConsumerState<Apply> createState() => ApplyState();
}

class ApplyState extends ConsumerState<Apply> {
  late List<String> currentProfile;
  List<PartyRole> roles = [];
  int? selectedRoleId;
  bool rolesLoading = true;
  String? poster;

  late final List<TextEditingController> bodyTextControllers = [];
  late final List<ScrollController> bodyScrollControllers = [];
  late TextEditingController timeTextController;
  late ScrollController whenToMeetScrollController;
  @override
  void initState() {
    super.initState();

    currentProfile = [
      widget.profile?.elementAtOrNull(0) ?? '',
      widget.profile?.elementAtOrNull(1) ?? '',
    ];
    for (int i = 0; i < 2; i++) {
      bodyTextControllers.add(TextEditingController(text: currentProfile[i]));
      bodyScrollControllers.add(ScrollController());
      if (bodyScrollControllers[0].hasClients) {
        bodyScrollControllers[0].jumpTo(0.0);
      }
    }
    timeTextController = TextEditingController();
    whenToMeetScrollController = ScrollController();
    selectedRoleId = widget.roleId;
    poster = widget.poster;
    fetchRoles();
    fetchPoster();
  }

  Future<void> fetchPoster() async {
    final activityId = widget.activityId;
    if (activityId == null || (poster != null && poster!.isNotEmpty)) return;
    try {
      final data = await ref
          .read(findRepositoryProvider)
          .getActivityDetail('$activityId');
      final fetched = data['imageUrl']?.toString();
      if (mounted && fetched != null && fetched.isNotEmpty) {
        setState(() => poster = fetched);
      }
    } catch (_) {}
  }

  Future<void> fetchRoles() async {
    final partyId = widget.partyId;
    if (partyId == null) {
      if (mounted) setState(() => rolesLoading = false);
      return;
    }
    try {
      final result = await ref
          .read(findRepositoryProvider)
          .getPartyRoles(partyId);
      if (mounted) {
        setState(() {
          roles = result;
          rolesLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => rolesLoading = false);
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
    return BasicLayout(
      title: '대외활동 지원',
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
                      child: ApplyInformation(
                        activityOverview: widget.activityName,
                        poster: poster,
                        scrollController: bodyScrollControllers[0],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '지원 직군',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.058,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Text(
                                ' *',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: rolesLoading
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: appPrimaryColor,
                                      ),
                                    ),
                                  )
                                : roles.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    child: Text(
                                      '모집 중인 직군이 없습니다.',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: screenWidth * 0.036,
                                      ),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: roles.map((role) {
                                        final selected =
                                            role.id == selectedRoleId;
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            right: screenWidth * 0.024,
                                          ),
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(
                                              screenWidth * 0.029,
                                            ),
                                            onTap: () {
                                              HapticFeedback.selectionClick();
                                              setState(
                                                () => selectedRoleId = role.id,
                                              );
                                            },
                                            child: AnimatedContainer(
                                              duration: const Duration(
                                                milliseconds: 200,
                                              ),
                                              curve: Curves.easeInOut,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 10,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: selected
                                                    ? appPrimaryColor
                                                    : const Color(0xFFF0F2F5),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      screenWidth * 0.029,
                                                    ),
                                              ),
                                              child: Text(
                                                '${role.roleName} ${role.currentCount}/${role.targetCount}',
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.034,
                                                  fontWeight: FontWeight.w600,
                                                  color: selected
                                                      ? Colors.white
                                                      : Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    ApplyBody(
                      section: '소개',
                      content: currentProfile[0],
                      onLoadButtonPressed: () => onLoadButtonPressed(0),
                      textController: bodyTextControllers[0],
                      isRequired: true,
                    ),
                    ApplyBody(
                      section: '스펙',
                      content: currentProfile[1],
                      onLoadButtonPressed: () => onLoadButtonPressed(1),
                      textController: bodyTextControllers[1],
                      isRequired: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        children: [
                          Text(
                            '활동 가능 시간',
                            style: TextStyle(
                              fontSize: screenWidth * 0.058,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(' *', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 704,
                      child: WhenToMeet(
                        readOnly: false,
                        scrollController: bodyScrollControllers[1],
                        timeTextController: timeTextController,
                        whenToMeetScrollController: whenToMeetScrollController,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 23)),
                  ],
                ),
              ),
            ),
          ),
          ApplyFooter(onApplyButtonPressed: onApplyButtonPressed),
        ],
      ),
      bottomNavigationBar: false,
    );
  }

  bool isSubmitting = false;

  void onApplyButtonPressed() {
    if (isSubmitting) return;
    if (selectedRoleId == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('지원할 직군을 선택해 주세요.')));
      return;
    }
    final requiredFields = [
      (bodyTextControllers[0], '소개'),
      (bodyTextControllers[1], '스펙'),
      (timeTextController, '활동 가능 시간'),
    ];
    for (final (controller, section) in requiredFields) {
      if (controller.text.trim().isEmpty) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('$section을(를) 입력해 주세요.')));
        return;
      }
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
        content: const Text('지원하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              setState(() => isSubmitting = true);
              HapticFeedback.lightImpact();
              bool succeeded = false;
              try {
                await ref
                    .read(applyRepositoryProvider)
                    .postApply(
                      ref.read(currentUserProvider) ?? 0,
                      widget.partyId ?? 0,
                      selectedRoleId ?? 0,
                      introduction: bodyTextControllers[0].text.trim(),
                    );
                succeeded = true;
              } catch (_) {}
              if (succeeded) {
                final userId = ref.read(currentUserProvider);
                final activityId = widget.activityId;
                if (userId != null && activityId != null) {
                  try {
                    await ref
                        .read(applyRepositoryProvider)
                        .submitAvailableTime(
                          userId,
                          activityId,
                          WhenToMeet.toSchedule(
                            ref.read(whenToMeetAvailableTimesProvider),
                          ),
                        );
                  } catch (_) {}
                }
              }
              if (mounted) setState(() => isSubmitting = false);
              if (mounted) {
                Navigator.pushNamed(
                  context,
                  succeeded ? PageRoutes.applySuccess : PageRoutes.applyFail,
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

  void onLoadButtonPressed(int i) {
    final profile = ref.read(profileProvider);
    bodyTextControllers[i].text = i == 0 ? profile.introduction : profile.spec;
  }
}
