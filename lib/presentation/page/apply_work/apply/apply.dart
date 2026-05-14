import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    currentProfile = ['', ''];
    for (int i = 0; i < 2; i++) {
      _bodyTextControllers.add(TextEditingController(text: currentProfile[i]));
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
      title: '대외활동 지원',
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
                    ),
                    ApplyBody(
                      section: '스펙',
                      content: currentProfile[1],
                      onLoadButtonPressed: () => onLoadButtonPressed(1),
                      textController: _bodyTextControllers[1],
                    ),
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
                    SizedBox(
                      height: 250,
                      child: WhenToMeet(
                        readOnly: false,
                        scrollController: _bodyScrollControllers[1],
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
            child: ApplyFooter(onApplyButtonPressed: onApplyButtonPressed),
          ),
        ],
      ),
      bottomNavigationBar: false,
    );
  }

  void onApplyButtonPressed() {}
  void onLoadButtonPressed(int i) {}
}
