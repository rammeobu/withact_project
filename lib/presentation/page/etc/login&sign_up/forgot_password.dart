import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  late TextEditingController emailTextController;
  late TextEditingController verificationCodeTextController;
  late TextEditingController newPasswordTextController;
  late TextEditingController confirmPasswordTextController;

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    verificationCodeTextController = TextEditingController();
    newPasswordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    verificationCodeTextController.dispose();
    newPasswordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return BasicLayout(
      title: '비밀번호 찾기',
      bottomNavigationBar: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            sectionHeader('이메일 인증', screenWidth),
            fieldRow(
              '이메일',
              emailTextController,
              '가입한 이메일을 입력해 주세요.',
              screenWidth,
              isRequired: true,
              additionalButton: Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.019),
                child: OutlinedButton(
                  onPressed: onSendCodeButtonPressed,
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
                    '코드 발송',
                    style: TextStyle(
                      color: const Color(0xFF3F3F3F),
                      fontSize: screenWidth * 0.032,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            fieldRow(
              '인증코드',
              verificationCodeTextController,
              '발송된 인증코드를 입력해 주세요.',
              screenWidth,
              isRequired: true,
            ),

            sectionHeader('새 비밀번호', screenWidth),
            fieldRow(
              '새 비밀번호',
              newPasswordTextController,
              '새 비밀번호를 입력해 주세요.',
              screenWidth,
              isRequired: true,
              isObscure: true,
            ),
            fieldRow(
              '비밀번호 확인',
              confirmPasswordTextController,
              '새 비밀번호를 다시 한 번 입력해 주세요.',
              screenWidth,
              isRequired: true,
              isObscure: true,
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.049,
                vertical: 42,
              ),
              child: OutlinedButton(
                onPressed: onResetButtonPressed,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 63),
                  side: const BorderSide(width: 0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.024),
                  ),
                ),
                child: Text(
                  '비밀번호 변경',
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

  Widget sectionHeader(String title, double width) {
    return Container(
      height: 59,
      width: width,
      color: const Color(0xFFE6E6E6),
      padding: EdgeInsets.only(left: width * 0.049),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: width * 0.044,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF3F3F3F),
        ),
      ),
    );
  }

  Widget fieldRow(
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
          additionalButton ?? Container(),
        ],
      ),
    );
  }

  Future<void> onSendCodeButtonPressed() async {
    final email = emailTextController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('이메일을 입력해 주세요.')));
      return;
    }
    try {
      await ref.read(accountRepositoryProvider).postEmailRequest(email);
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(content: Text('인증번호가 발송되었습니다.')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  Future<void> onResetButtonPressed() async {
    final requiredFields = [
      (emailTextController, '이메일'),
      (verificationCodeTextController, '인증코드'),
      (newPasswordTextController, '새 비밀번호'),
      (confirmPasswordTextController, '비밀번호 확인'),
    ];
    for (final (controller, section) in requiredFields) {
      if (controller.text.trim().isEmpty) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('$section을(를) 입력해 주세요.')));
        return;
      }
    }
    if (newPasswordTextController.text != confirmPasswordTextController.text) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('새 비밀번호가 일치하지 않습니다.')));
      return;
    }
    try {
      await ref.read(accountRepositoryProvider).postEmailVerify(
        emailTextController.text.trim(),
        verificationCodeTextController.text.trim(),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(e.toString())));
      }
      return;
    }
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        PageRoutes.login,
        (route) => false,
      );
    }
  }
}
