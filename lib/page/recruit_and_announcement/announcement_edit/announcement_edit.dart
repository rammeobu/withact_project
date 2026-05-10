import 'package:flutter/material.dart';
import 'package:party_maker/page/recruit_and_announcement/announcement_edit/announcement_edit_body2.dart';
import 'package:party_maker/page/recruit_and_announcement/announcement_edit/announcement_edit_body3.dart';
import '../../future&component/layout/basic_layout.dart';
import 'announcement_edit_body.dart';
import 'announcement_edit_footer.dart';

class AnnouncementEdit extends StatefulWidget {
  final List<String>? profile;
  final String? poster;
  const AnnouncementEdit({super.key, this.profile, this.poster});

  @override
  State<AnnouncementEdit> createState() => _AnnouncementEditState();
}

class _AnnouncementEditState extends State<AnnouncementEdit> {
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
      title: '공고 편집',
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
                    AnnouncementEditBody(
                      section: '활동 이름',
                      onSearchButtonPressed: onSearchButtonPressed,
                    ),
                    const AnnouncementEditBody(section: '파티 이름/소개'),
                    const AnnouncementEditBody2(),
                    const SizedBox(height: 20.0),
                    AnnouncementEditBody3(
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
            child: AnnouncementEditFooter(
              onSaveAndExitButtonPressed: onSaveAndExitButtonPressed,
            ),
          ),
        ],
      ),
    );
  }

  void onSearchButtonPressed() {}
  void onSaveAndExitButtonPressed() {}
}
