import 'package:flutter/material.dart';
import 'package:party_maker/page/recruit_and_announcement/work_recruit/work_recruit_body2.dart';
import 'package:party_maker/page/recruit_and_announcement/work_recruit/work_recruit_body3.dart';
import '../../future&component/layout/basic_layout.dart';
import 'work_recruit_body.dart';
import 'work_recruit_footer.dart';

class WorkRecruit extends StatefulWidget {
  final List<String>? profile;
  final String? poster;
  const WorkRecruit({super.key, this.profile, this.poster});

  @override
  State<WorkRecruit> createState() => _WorkRecruitState();
}

class _WorkRecruitState extends State<WorkRecruit> {
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
      title: '대외활동 모집',
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const WorkRecruitBody(section: '활동 이름'),
                    const WorkRecruitBody(section: '파티 이름/소개'),
                    const WorkRecruitBody2(),
                    const SizedBox(height: 20.0),
                    WorkRecruitBody3(
                      primaryScrollController: _scrollController,
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
            child: WorkRecruitFooter(
              onRecruitStartButtonPressed: onRecruitStartButtonPressed,
            ),
          ),
        ],
      ),
    );
  }

  void onSearchButtonPressed() {}
  void onRecruitStartButtonPressed() {}
}
