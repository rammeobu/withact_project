import 'package:flutter/material.dart';
import '../../future&component/component/when_to_meet.dart';
import '../../future&component/layout/basic_layout.dart';
import 'applying_work_body1.dart';
import 'applying_work_footer.dart';
import 'applying_work_information.dart';

class ApplyingWork extends StatefulWidget {
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
  State<ApplyingWork> createState() => _ApplyingWorkState();
}

class _ApplyingWorkState extends State<ApplyingWork> {
  List<bool> editingMode = [false, false, false];
  late List<String> currentProfile;

  late final List<TextEditingController> _bodyTextControllers = [];
  late final List<ScrollController> _bodyScrollControllers = [];

  @override
  void initState() {
    super.initState();

    currentProfile = List.from(widget.profile);
    for (int i = 0; i < 4; i++) {
      if (i > 0 && i < 3) {
        _bodyTextControllers.add(
          TextEditingController(text: widget.profile[i - 1]),
        );
      }
      _bodyScrollControllers.add(ScrollController());

      if (_bodyScrollControllers[0].hasClients) {
        _bodyScrollControllers[0].jumpTo(0.0);
      }
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BasicLayout(
      title: '지원 중인 활동',
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _bodyScrollControllers[0],
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15.0,
                  top: screenHeight * 0.01,
                  right: 15.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: ApplyingWorkInformation(
                        workOverview: widget.workName,
                        poster: widget.poster,
                        scrollController: _bodyScrollControllers[0],
                      ),
                    ),
                    ApplyingWorkBody(
                      section: '소개',
                      content: currentProfile[0],
                      editingMode: editingMode[0],
                      onEditButtonPressed: () => onEditButtonPressed(0),
                      textController: _bodyTextControllers[0],
                      scrollController: _bodyScrollControllers[1],
                    ),
                    ApplyingWorkBody(
                      section: '스펙',
                      content: currentProfile[1],
                      editingMode: editingMode[1],
                      onEditButtonPressed: () => onEditButtonPressed(1),
                      textController: _bodyTextControllers[1],
                      scrollController: _bodyScrollControllers[2],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            '활동 가능 시간',
                            style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () => onEditButtonPressed(2),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            fixedSize: const Size(60, 35),
                            side: const BorderSide(width: 0.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10.0),
                            ),
                            backgroundColor: editingMode[2]
                                ? const Color(0xff5764f0)
                                : const Color(0xff1cb879),
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            editingMode[2] ? '저장' : '수정',
                            style: const TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 250,
                      child: WhenToMeet(
                        readOnly: !editingMode[2],
                        scrollController: _bodyScrollControllers[3],
                      ),
                    ),
                    const SizedBox(height: 20.0),
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

  void onApplyCancelButtonPressed() {}
  void onApplyListButtonPressed() {}
  void onEditButtonPressed(int i) {
    setState(() {
      if (editingMode[i]) {
        if (i > 0 && i < 3) {
          String updatedContent = _bodyTextControllers[i - 1].text;

          currentProfile[i - 1] = updatedContent;

          if (_bodyScrollControllers[i].hasClients) {
            _bodyScrollControllers[i].jumpTo(0.0);
          } else if (i == 2) {}
        }
      }
      editingMode[i] = !editingMode[i];
    });
  }
}
