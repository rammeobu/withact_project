import 'package:flutter/material.dart';
import '../../future&component/component/when_to_meet.dart';
import '../../future&component/layout/basic_layout.dart';
import 'applying_work_body1.dart';
import 'applying_work_footer.dart';
import 'applying_work_information.dart';

class ApplyingWork extends StatefulWidget {
  final String workName;
  final List<String>? profile;
  final String? poster;
  const ApplyingWork({
    super.key,
    required this.workName,
    this.profile,
    this.poster,
  });

  @override
  State<ApplyingWork> createState() => _ApplicantProfileState();
}

class _ApplicantProfileState extends State<ApplyingWork> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0.0);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
              controller: _scrollController,
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
                        scrollController: _scrollController,
                      ),
                    ),
                    ApplyingWorkBody(
                      section: '소개',
                      content: widget.profile?[0],
                    ),
                    ApplyingWorkBody(
                      section: '스펙',
                      content: widget.profile?[1],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        '활동 가능 시간',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 250,
                      child: WhenToMeet(readOnly: true),
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
    );
  }

  void onApplyCancelButtonPressed() {}
  void onApplyListButtonPressed() {}
}
