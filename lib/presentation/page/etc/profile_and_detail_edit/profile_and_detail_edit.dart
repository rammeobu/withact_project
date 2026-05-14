import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/etc/profile_and_detail_edit/profile_and_detail_edit_body_1.dart';
import 'package:party_maker/presentation/page/etc/profile_and_detail_edit/profile_and_detail_edit_body_2.dart';
import 'package:party_maker/presentation/page/etc/profile_and_detail_edit/profile_and_detail_edit_footer.dart';
import 'package:party_maker/presentation/page/etc/profile_and_detail_edit/profile_card_edit.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

class ProfileAndDetailEdit extends StatefulWidget {
  final List<String> profileContent;
  final String introduction;
  final String spec;
  final List<String> preference;

  const ProfileAndDetailEdit({
    super.key,
    required this.profileContent,
    required this.introduction,
    required this.spec,
    required this.preference,
  });

  @override
  State<ProfileAndDetailEdit> createState() => _ProfileAndDetailEditState();
}

class _ProfileAndDetailEditState extends State<ProfileAndDetailEdit> {
  late ScrollController scrollController;
  late List<TextEditingController> textControllers;
  bool anonymousFlag = false;
  String? profileImagePath;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    textControllers = [
      ...List.generate(
        4,
        (int i) => TextEditingController(text: widget.profileContent[i]),
      ),
      TextEditingController(text: widget.introduction),
      TextEditingController(text: widget.spec),
      ...List.generate(
        3,
        (int i) => TextEditingController(text: widget.preference[i]),
      ),
    ];
  }

  @override
  void dispose() {
    scrollController.dispose();
    for (TextEditingController controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BasicLayout(
      title: '프로필/상세정보 수정',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.007,
                      ),
                      child: const Text(
                        '프로필 수정',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    ProfileCardEdit(
                      controllers: textControllers.sublist(0, 4),
                      profileImage: profileImagePath,
                      onProfileImageTap: onProfileImageTap,
                      anonymousFlag: anonymousFlag,
                      onAnonymousChanged: (bool? val) =>
                          setState(() => anonymousFlag = val ?? false),
                      onProfileSaveButtonPressed: onProfileSaveButtonPressed,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.007),
                      child: const Text(
                        '상세정보 수정',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    ProfileAndDetailEditBody1(
                      section: '소개',
                      controller: textControllers[4],
                    ),
                    ProfileAndDetailEditBody1(
                      section: '스펙',
                      controller: textControllers[5],
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.007,
                      ),
                      child: const Text(
                        '선호 활동 정보',
                        style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ProfileAndDetailEditBody2(
                      controllers: textControllers.sublist(6, 9),
                      onDetailSaveButtonPressed: onDetailSaveButtonPressed,
                    ),
                  ],
                ),
              ),
            ),
            ProfileAndDetailEditFooter(
              onSaveAndExitButtonPressed: onSaveAndExitButtonPressed,
            ),
          ],
        ),
      ),
      bottomNavigationBar: false,
    );
  }

  void onProfileImageTap() {}
  void onDetailSaveButtonPressed() {}
  void onProfileSaveButtonPressed() {}
  void onSaveAndExitButtonPressed() {}
}
