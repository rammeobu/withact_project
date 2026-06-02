import 'package:flutter/material.dart';
import 'package:party_maker/app.dart';
import '../../future&component/component/when_to_meet.dart';
import '../../future&component/layout/basic_layout.dart';
import 'apply_body1.dart';
import 'apply_footer.dart';
import 'apply_information.dart';

class Apply extends StatefulWidget {
  final String workName;
  final List<String>? profile;
  final String? poster;
  const Apply({super.key, required this.workName, this.profile, this.poster});

  @override
  State<Apply> createState() => _ApplyState();
}

class _ApplyState extends State<Apply> {
  late List<String> currentProfile;

  late final List<TextEditingController> _bodyTextControllers = [];
  late final List<ScrollController> _bodyScrollControllers = [];
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
      _bodyTextControllers.add(TextEditingController(text: currentProfile[i]));
      _bodyScrollControllers.add(ScrollController());
      if (_bodyScrollControllers[0].hasClients) {
        _bodyScrollControllers[0].jumpTo(0.0);
      }
    }
    timeTextController = TextEditingController();
    whenToMeetScrollController = ScrollController();
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
    return BasicLayout(
      title: '대외활동 지원',
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
                      child: ApplyInformation(
                        workOverview: widget.workName,
                        poster: widget.poster,
                        scrollController: _bodyScrollControllers[0],
                      ),
                    ),
                    ApplyBody(
                      section: '소개',
                      content: currentProfile[0],
                      onLoadButtonPressed: () => onLoadButtonPressed(0),
                      textController: _bodyTextControllers[0],
                      isRequired: true,
                    ),
                    ApplyBody(
                      section: '스펙',
                      content: currentProfile[1],
                      onLoadButtonPressed: () => onLoadButtonPressed(1),
                      textController: _bodyTextControllers[1],
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
                        scrollController: _bodyScrollControllers[1],
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

  void onApplyButtonPressed() {
    final requiredFields = [
      (_bodyTextControllers[0], '소개'),
      (_bodyTextControllers[1], '스펙'),
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('지원하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              const bool succeeded = true;
              Navigator.pushNamed(
                context,
                succeeded ? PageRoutes.applySuccess : PageRoutes.applyFail,
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

  void onLoadButtonPressed(int i) {
    _bodyTextControllers[i].text = currentProfile[i];
  }
}
