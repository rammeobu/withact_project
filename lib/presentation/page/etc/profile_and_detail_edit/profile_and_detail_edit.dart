import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:party_maker/presentation/page/etc/profile_and_detail_edit/profile_and_detail_edit_body_1.dart';
import 'package:party_maker/presentation/page/etc/profile_and_detail_edit/profile_and_detail_edit_body_2.dart';
import 'package:party_maker/presentation/page/etc/profile_and_detail_edit/profile_and_detail_edit_footer.dart';
import 'package:party_maker/presentation/page/etc/profile_and_detail_edit/profile_card_edit.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

class _ProfileAnonymousNotifier extends Notifier<bool> {
  @override
  bool build() => false;
}

final profileAnonymousProvider =
    NotifierProvider.autoDispose<_ProfileAnonymousNotifier, bool>(
      _ProfileAnonymousNotifier.new,
    );

class _ProfileImagePathNotifier extends Notifier<String?> {
  @override
  String? build() => null;
}

final profileImagePathProvider =
    NotifierProvider.autoDispose<_ProfileImagePathNotifier, String?>(
      _ProfileImagePathNotifier.new,
    );

class ProfileAndDetailEdit extends ConsumerStatefulWidget {
  final List<String> profileContent;
  final String introduction;
  final String spec;
  final List<String> favorites;

  const ProfileAndDetailEdit({
    super.key,
    required this.profileContent,
    required this.introduction,
    required this.spec,
    required this.favorites,
  });

  @override
  ConsumerState<ProfileAndDetailEdit> createState() =>
      _ProfileAndDetailEditState();
}

class _ProfileAndDetailEditState extends ConsumerState<ProfileAndDetailEdit> {
  late ScrollController scrollController;
  late List<TextEditingController> textControllers;

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
        (int i) => TextEditingController(text: widget.favorites[i]),
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final anonymousFlag = ref.watch(profileAnonymousProvider);
    final profileImagePath = ref.watch(profileImagePathProvider);
    return BasicLayout(
      title: '프로필/상세정보 수정',
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.036),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      child: Text(
                        '프로필 수정',
                        style: TextStyle(
                          fontSize: screenWidth * 0.058,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    ProfileCardEdit(
                      controllers: textControllers.sublist(0, 4),
                      profileImage: profileImagePath,
                      onProfileImageTap: onProfileImageTap,
                      anonymousFlag: anonymousFlag,
                      onAnonymousChanged: (bool? isAnonymous) =>
                          ref.read(profileAnonymousProvider.notifier).state =
                              isAnonymous ?? false,
                      onProfileSaveButtonPressed: onProfileSaveButtonPressed,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        '상세정보 수정',
                        style: TextStyle(
                          fontSize: screenWidth * 0.058,
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
                    const Padding(padding: EdgeInsets.only(top: 8)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        '선호 활동 정보',
                        style: TextStyle(
                          fontSize: screenWidth * 0.058,
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

  void onProfileImageTap() async {
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('갤러리'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('카메라'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;

    final XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null && mounted) {
      ref.read(profileImagePathProvider.notifier).state = image.path;
    }
  }

  void onProfileSaveButtonPressed() {
    // TODO: 입력된 프로필 카드 정보를 서버에 저장하는 기능 구현 (백엔드와 협의 필요)
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('저장되었습니다.'),
          backgroundColor: Colors.black,
        ),
      );
  }

  void onDetailSaveButtonPressed() {
    // TODO: 입력된 상세정보(선호 역할, 분야, 도메인)를 서버에 저장하는 기능 구현 (백엔드와 협의 필요)
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('저장되었습니다.'),
          backgroundColor: Colors.black,
        ),
      );
  }

  void onSaveAndExitButtonPressed() {
    final sections = ['이름', '기술', '소속', '전공'];
    for (int i = 0; i < 4; i++) {
      if (textControllers[i].text.trim().isEmpty) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text('${sections[i]}을(를) 입력해 주세요.')),
          );
        return;
      }
    }
    Navigator.pop(context);
  }
}
