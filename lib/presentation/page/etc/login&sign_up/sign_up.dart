import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

class _SignUpPasswordMatchNotifier extends Notifier<bool> {
  @override
  bool build() => true;
}

final signUpPasswordMatchProvider =
    NotifierProvider.autoDispose<_SignUpPasswordMatchNotifier, bool>(
      _SignUpPasswordMatchNotifier.new,
    );

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  late TextEditingController confirmPasswordTextController;
  late TextEditingController nameTextController;
  late TextEditingController majorTextController;
  late TextEditingController belongTextController;
  late TextEditingController techTextController;
  late List<TextEditingController> interestTextControllers;
  late TextEditingController introTextController;
  late TextEditingController specTextController;

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    nameTextController = TextEditingController();
    majorTextController = TextEditingController();
    belongTextController = TextEditingController();
    techTextController = TextEditingController();
    interestTextControllers = List.generate(
      3,
      (int i) => TextEditingController(),
    );
    introTextController = TextEditingController();
    specTextController = TextEditingController();

    passwordTextController.addListener(() {
      ref.read(signUpPasswordMatchProvider.notifier).state =
          passwordTextController.text == confirmPasswordTextController.text;
    });
    confirmPasswordTextController.addListener(() {
      ref.read(signUpPasswordMatchProvider.notifier).state =
          passwordTextController.text == confirmPasswordTextController.text;
    });
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    nameTextController.dispose();
    majorTextController.dispose();
    belongTextController.dispose();
    techTextController.dispose();
    for (TextEditingController controller in interestTextControllers) {
      controller.dispose();
    }
    introTextController.dispose();
    specTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool passwordMatch = ref.watch(signUpPasswordMatchProvider);

    return BasicLayout(
      title: '회원가입',
      bottomNavigationBar: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            sectionHeaderBuilder('계정 정보', screenWidth),
            membershipInformationWriteFieldBuilder(
              '이메일',
              emailTextController,
              '이메일을 입력해 주세요.',
              screenWidth,
              isRequired: true,
              additionalButton: Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.019),
                child: OutlinedButton(
                  onPressed: onEmailAuthButtonPressed,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.019,
                    ),
                    fixedSize: Size(screenWidth * 0.22, 41),
                    side: const BorderSide(width: 0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.024),
                    ),
                  ),
                  child: Text(
                    '이메일 인증',
                    style: TextStyle(
                      color: const Color(0xFF3F3F3F),
                      fontSize: screenWidth * 0.032,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            membershipInformationWriteFieldBuilder(
              '비밀번호',
              passwordTextController,
              '비밀번호를 입력해 주세요.',
              screenWidth,
              isRequired: true,
              isObscure: true,
            ),
            membershipInformationWriteFieldBuilder(
              '비밀번호 확인',
              confirmPasswordTextController,
              '비밀번호를 다시 한 번 입력해 주세요.',
              screenWidth,
              isRequired: true,
              isObscure: true,
            ),

            if (!passwordMatch && confirmPasswordTextController.text.isNotEmpty)
              Container(
                width: screenWidth,
                padding: EdgeInsets.only(
                  left: screenWidth * 0.049,
                  top: 12,
                  bottom: 12,
                ),
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.2),
                  ),
                ),
                child: Text(
                  '비밀번호가 일치하지 않습니다.',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: screenWidth * 0.032,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

            sectionHeaderBuilder('상세 프로필', screenWidth),
            membershipInformationWriteFieldBuilder(
              '이름',
              nameTextController,
              '이름을 입력해주세요.',
              screenWidth,
              isRequired: true,
            ),
            membershipInformationWriteFieldBuilder(
              '소속',
              belongTextController,
              '소속 학교를 입력해주세요.',
              screenWidth,
              isRequired: true,
            ),
            membershipInformationWriteFieldBuilder(
              '기술',
              techTextController,
              '보유 기술 스택을 입력해주세요.',
              screenWidth,
              isRequired: true,
            ),
            membershipInformationWriteFieldBuilder(
              '전공',
              majorTextController,
              '전공을 입력해주세요.',
              screenWidth,
              isRequired: true,
            ),

            sectionHeaderBuilder('선호 정보', screenWidth),
            membershipInformationWriteFieldBuilder(
              '선호 역할',
              interestTextControllers[0],
              '기획자, 디자이너, 개발 등',
              screenWidth,
            ),
            membershipInformationWriteFieldBuilder(
              '선호 분야',
              interestTextControllers[1],
              '핀테크, 헬스케어 등',
              screenWidth,
            ),
            membershipInformationWriteFieldBuilder(
              '선호 도메인',
              interestTextControllers[2],
              '플랫폼, 이커머스 등',
              screenWidth,
            ),

            sectionHeaderBuilder('소개', screenWidth),
            Container(
              width: screenWidth,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.049,
                vertical: 12,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.2),
                ),
              ),
              child: TextField(
                controller: introTextController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: '자신을 간단히 소개해 주세요.',
                  hintStyle: TextStyle(
                    fontSize: screenWidth * 0.034,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            sectionHeaderBuilder('스펙', screenWidth),
            Container(
              width: screenWidth,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.049,
                vertical: 12,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.2),
                ),
              ),
              child: TextField(
                controller: specTextController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: '자신의 주요 경력을 적어주세요.',
                  hintStyle: TextStyle(
                    fontSize: screenWidth * 0.034,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.049,
                vertical: 42,
              ),
              child: OutlinedButton(
                onPressed: onSignUpCompleteButtonPressed,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 63),
                  side: const BorderSide(width: 0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.024),
                  ),
                ),
                child: Text(
                  '가입 완료',
                  style: TextStyle(
                    color: const Color(0xFF3F3F3F),
                    fontSize: screenWidth * 0.044,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionHeaderBuilder(String sectionTitle, double sectionWidth) {
    return Container(
      height: 59,
      width: sectionWidth,
      color: const Color(0xFFE6E6E6),
      padding: EdgeInsets.only(left: sectionWidth * 0.049),
      alignment: Alignment.centerLeft,
      child: Text(
        sectionTitle,
        style: TextStyle(
          fontSize: sectionWidth * 0.044,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF3F3F3F),
        ),
      ),
    );
  }

  Widget membershipInformationWriteFieldBuilder(
    String label,
    TextEditingController controller,
    String hint,
    double width, {
    bool isRequired = false,
    bool isObscure = false,
    Widget? additionalButton,
  }) {
    return Container(
      height: 59,
      width: width,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: width * 0.3,
            padding: EdgeInsets.only(left: width * 0.049),
            decoration: BoxDecoration(
              border: BoxBorder.fromLTRB(right: const BorderSide(width: 0.5)),
            ),
            child: Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: const Color(0xFF3F3F3F),
                    fontSize: width * 0.036,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (isRequired)
                  const Text(' *', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isObscure,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: width * 0.034,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: width * 0.024),
              ),
            ),
          ),
          (additionalButton != null) ? additionalButton : Container(),
        ],
      ),
    );
  }

  void onEmailAuthButtonPressed() {
    // TODO: 입력된 이메일이 유효한 경우 해당 이메일을 통한 인증 기능 구현 (백엔드와 협의 필요)
  }

  void onSignUpCompleteButtonPressed() {
    final requiredFields = [
      (emailTextController, '이메일'),
      (passwordTextController, '비밀번호'),
      (confirmPasswordTextController, '비밀번호 확인'),
      (nameTextController, '이름'),
      (belongTextController, '소속'),
      (techTextController, '기술'),
      (majorTextController, '전공'),
    ];
    for (final (controller, section) in requiredFields) {
      if (controller.text.trim().isEmpty) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('$section을(를) 입력해 주세요.')));
        return;
      }
    }
    final emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(emailTextController.text.trim())) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('올바른 이메일 형식이 아닙니다.')));
      return;
    }
    if (passwordTextController.text != confirmPasswordTextController.text) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('비밀번호가 일치하지 않습니다.')));
      return;
    }
    // TODO: 회원 가입 완료 혹은 실패 페이지(작업 필요)로 이동하는 라우트 필요 (가입 완료의 경우 해당 페이지 이후 대기 화면으로 이동하는 버튼이 존재해야 하며, 실패의 경우 네트워크 오류라면 네트워크 오류, 필수 입력 사항 미입력이라면 필수 입력 사항이 입력되지 않았다는 오류 메시지 출력 필요)
  }
}
