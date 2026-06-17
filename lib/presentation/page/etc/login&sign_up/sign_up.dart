import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';
import 'package:party_maker/presentation/page/future&component/component/no_scale.dart';

class SignUpPasswordMatchNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void setMatch(bool match) {
    state = match;
  }
}

final signUpPasswordMatchProvider =
    NotifierProvider.autoDispose<SignUpPasswordMatchNotifier, bool>(
      SignUpPasswordMatchNotifier.new,
    );

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => SignUpState();
}

class SignUpState extends ConsumerState<SignUp> {
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
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isSubmitting = false;
  bool isSendingCode = false;

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
      ref.read(signUpPasswordMatchProvider.notifier).setMatch(
          passwordTextController.text == confirmPasswordTextController.text);
    });
    confirmPasswordTextController.addListener(() {
      ref.read(signUpPasswordMatchProvider.notifier).setMatch(
          passwordTextController.text == confirmPasswordTextController.text);
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
                  onPressed: isSendingCode ? null : onEmailAuthButtonPressed,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.019,
                    ),
                    fixedSize: Size(screenWidth * 0.22, 44),
                    side: const BorderSide(width: 0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.024),
                    ),
                  ),
                  child: isSendingCode
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF3F3F3F),
                          ),
                        )
                      : Text(
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
              isObscure: obscurePassword,
              onToggleObscure: () =>
                  setState(() => obscurePassword = !obscurePassword),
            ),
            membershipInformationWriteFieldBuilder(
              '비밀번호 확인',
              confirmPasswordTextController,
              '비밀번호를 다시 한 번 입력해 주세요.',
              screenWidth,
              isRequired: true,
              isObscure: obscureConfirmPassword,
              onToggleObscure: () => setState(
                () => obscureConfirmPassword = !obscureConfirmPassword,
              ),
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
              child: NoScale(
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
              child: NoScale(
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
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.049,
                vertical: 42,
              ),
              child: OutlinedButton(
                onPressed: isSubmitting ? null : onSignUpCompleteButtonPressed,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 63),
                  side: const BorderSide(width: 0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.024),
                  ),
                ),
                child: isSubmitting
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF3F3F3F),
                        ),
                      )
                    : Text(
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
    VoidCallback? onToggleObscure,
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
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      label,
                      maxLines: 1,
                      style: TextStyle(
                        color: const Color(0xFF3F3F3F),
                        fontSize: width * 0.036,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                suffixIcon: onToggleObscure != null
                    ? IconButton(
                        onPressed: onToggleObscure,
                        icon: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility,
                          size: width * 0.05,
                          color: Colors.grey,
                        ),
                      )
                    : null,
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

  Future<void> onEmailAuthButtonPressed() async {
    if (isSendingCode) return;
    final email = emailTextController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('이메일을 입력해 주세요.')));
      return;
    }
    setState(() => isSendingCode = true);
    HapticFeedback.lightImpact();
    try {
      await ref.read(accountRepositoryProvider).postEmailRequest(email);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('인증번호 발송에 실패했습니다. 대학 이메일(.ac.kr)인지 확인해 주세요.'),
            ),
          );
        setState(() => isSendingCode = false);
      }
      return;
    }
    if (mounted) setState(() => isSendingCode = false);
    if (!mounted) return;
    final codeController = TextEditingController();
    final code = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        content: TextField(
          controller: codeController,
          decoration: const InputDecoration(hintText: '인증번호 6자리를 입력해 주세요.'),
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(dialogContext, codeController.text.trim()),
            child: const Text('확인'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('취소'),
          ),
        ],
      ),
    );
    codeController.dispose();
    if (code == null || code.isEmpty) return;
    try {
      await ref.read(accountRepositoryProvider).postEmailAuth(email, code);
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(content: Text('이메일 인증이 완료되었습니다.')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('인증번호가 올바르지 않습니다.')),
          );
      }
    }
  }

  Future<void> onSignUpCompleteButtonPressed() async {
    if (isSubmitting) return;
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
    final emailRegex = RegExp(r'^[\w.+-]+@[\w.-]+\.[a-zA-Z]{2,}$');
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
    setState(() => isSubmitting = true);
    HapticFeedback.lightImpact();
    try {
      await ref.read(accountRepositoryProvider).postSignUp(
        emailTextController.text.trim(),
        passwordTextController.text,
        nameTextController.text.trim(),
        belongTextController.text.trim(),
        majorTextController.text.trim(),
        techTextController.text.trim(),
        introduction: introTextController.text.trim(),
        preference: interestTextControllers
            .map((controller) => controller.text.trim())
            .where((text) => text.isNotEmpty)
            .toList(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(content: Text('회원가입이 완료되었습니다.')));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('회원가입에 실패했습니다. 잠시 후 다시 시도해 주세요.')),
          );
      }
    } finally {
      if (mounted) setState(() => isSubmitting = false);
    }
  }
}
