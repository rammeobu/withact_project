import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:party_maker/data/models/profile_data_structures.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/presentation/page/etc/profile_and_detail_edit/profile_and_detail_edit_body_1.dart';
import 'package:party_maker/presentation/page/etc/profile_and_detail_edit/profile_and_detail_edit_body_2.dart';
import 'package:party_maker/presentation/page/etc/profile_and_detail_edit/profile_and_detail_edit_footer.dart';
import 'package:party_maker/presentation/page/etc/profile_and_detail_edit/profile_card_edit.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

class ProfileAnonymousNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setAnonymous(bool anonymous) {
    state = anonymous;
  }
}

final profileAnonymousProvider =
    NotifierProvider.autoDispose<ProfileAnonymousNotifier, bool>(
      ProfileAnonymousNotifier.new,
    );

class ProfileImagePathNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setPath(String? path) {
    state = path;
  }
}

final profileImagePathProvider =
    NotifierProvider.autoDispose<ProfileImagePathNotifier, String?>(
      ProfileImagePathNotifier.new,
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
      ProfileAndDetailEditState();
}

class ProfileAndDetailEditState extends ConsumerState<ProfileAndDetailEdit> {
  late ScrollController scrollController;
  late List<TextEditingController> textControllers;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    final saved = ref.read(profileProvider);
    final content = saved.hasData ? saved.profileContent : widget.profileContent;
    final introduction = saved.hasData ? saved.introduction : widget.introduction;
    final spec = saved.hasData ? saved.spec : widget.spec;
    final favorites = saved.hasData ? saved.favorites : widget.favorites;

    textControllers = [
      ...List.generate(
        4,
        (int i) =>
            TextEditingController(text: i < content.length ? content[i] : ''),
      ),
      TextEditingController(text: introduction),
      TextEditingController(text: spec),
      ...List.generate(
        3,
        (int i) =>
            TextEditingController(text: i < favorites.length ? favorites[i] : ''),
      ),
    ];

    if (saved.hasData) {
      WidgetsBinding.instance.addPostFrameCallback((timestamp) {
        ref.read(profileImagePathProvider.notifier).setPath(saved.imagePath);
        ref
            .read(profileAnonymousProvider.notifier)
            .setAnonymous(saved.anonymous);
      });
    }
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
                          ref.read(profileAnonymousProvider.notifier).setAnonymous(
                              isAnonymous ?? false),
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
      ref.read(profileImagePathProvider.notifier).setPath(image.path);
    }
  }

  void onProfileSaveButtonPressed() {
    ref.read(profileProvider.notifier).setCard(
          profileContent: textControllers
              .sublist(0, 4)
              .map((controller) => controller.text.trim())
              .toList(),
          imagePath: ref.read(profileImagePathProvider),
          anonymous: ref.read(profileAnonymousProvider),
        );
    persistProfile();
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
    ref.read(profileProvider.notifier).setDetail(
          introduction: textControllers[4].text.trim(),
          spec: textControllers[5].text.trim(),
          favorites: textControllers
              .sublist(6, 9)
              .map((controller) => controller.text.trim())
              .toList(),
        );
    persistProfile();
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
    ref.read(profileProvider.notifier).setProfile(
          ProfileState(
            profileContent: textControllers
                .sublist(0, 4)
                .map((controller) => controller.text.trim())
                .toList(),
            introduction: textControllers[4].text.trim(),
            spec: textControllers[5].text.trim(),
            favorites: textControllers
                .sublist(6, 9)
                .map((controller) => controller.text.trim())
                .toList(),
            imagePath: ref.read(profileImagePathProvider),
            anonymous: ref.read(profileAnonymousProvider),
          ),
        );
    persistProfile();
    Navigator.pop(context);
  }

  void persistProfile() {
    final userId = ref.read(currentUserProvider);
    if (userId == null) return;
    ref
        .read(accountRepositoryProvider)
        .putProfile(userId.toString(), ref.read(profileProvider))
        .catchError((error) {});
  }
}
