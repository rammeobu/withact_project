import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/providers/repository_providers.dart';

import '../../../../app.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => LoginState();
}

class LoginState extends ConsumerState<Login> {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  bool obscurePassword = true;
  bool isSubmitting = false;
  final RegExp emailVerification = RegExp(r'^[\w.+-]+@[\w.-]+\.[a-zA-Z]{2,}$');

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final String emailText = emailTextController.text.trim();
    final String? emailError =
        emailText.isEmpty || emailVerification.hasMatch(emailText)
        ? null
        : '올바른 이메일 형식이 아닙니다.';

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/app_logo.png',
                  width: screenWidth * 0.219,
                  height: screenWidth * 0.219,
                  fit: BoxFit.contain,
                  cacheWidth: 400,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 84),
                  child: Container(
                    width: screenWidth * 0.7,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.036,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.029),
                      border: Border.all(
                        color: const Color(0xFFB4B4B4),
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 17),
                          child: Row(
                            children: [
                              Text(
                                '이메일',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.034,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Text(
                                ' *',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: TextField(
                            controller: emailTextController,
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              hintText: 'E-mail',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: screenWidth * 0.034,
                              ),
                              errorText: emailError,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.024,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  screenWidth * 0.024,
                                ),
                                borderSide: const BorderSide(
                                  color: Color(0xFFB4B4B4),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  screenWidth * 0.024,
                                ),
                                borderSide: const BorderSide(
                                  color: appPrimaryColor,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  screenWidth * 0.024,
                                ),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  screenWidth * 0.024,
                                ),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 11, bottom: 8),
                          child: Row(
                            children: [
                              Text(
                                '비밀번호',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.034,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Text(
                                ' *',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        TextField(
                          controller: passwordTextController,
                          obscureText: obscurePassword,
                          decoration: InputDecoration(
                            hintText: 'password',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: screenWidth * 0.034,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => setState(
                                () => obscurePassword = !obscurePassword,
                              ),
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: screenWidth * 0.05,
                                color: Colors.grey,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.024,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.024,
                              ),
                              borderSide: const BorderSide(
                                color: Color(0xFFB4B4B4),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.024,
                              ),
                              borderSide: const BorderSide(
                                color: appPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 21),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: isSubmitting
                                  ? null
                                  : onLoginButtonPressed,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appPrimaryColor,
                                foregroundColor: Colors.white,
                                disabledBackgroundColor: appPrimaryColor,
                                fixedSize: Size(screenWidth * 0.6, 56),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    screenWidth * 0.019,
                                  ),
                                ),
                              ),
                              child: isSubmitting
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      '로그인',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.044,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: onForgotPasswordButtonPressed,
                              child: Text(
                                '비밀번호 찾기',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: screenWidth * 0.034,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: onSignUpButtonPressed,
                              child: Text(
                                '회원가입',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: screenWidth * 0.034,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 17)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onLoginButtonPressed() async {
    if (isSubmitting) return;
    if (emailTextController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('이메일을 입력해 주세요.')));
      return;
    }
    if (!emailVerification.hasMatch(emailTextController.text.trim())) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('올바른 이메일 형식이 아닙니다.')));
      return;
    }
    if (passwordTextController.text.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('비밀번호를 입력해 주세요.')));
      return;
    }
    setState(() => isSubmitting = true);
    HapticFeedback.lightImpact();
    try {
      final userId = await ref
          .read(accountRepositoryProvider)
          .postLogin(
            emailTextController.text.trim(),
            passwordTextController.text,
          );
      ref.read(currentUserProvider.notifier).setUserId(userId);
      ref.read(loggedInProvider.notifier).setLoggedIn(true);
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          PageRoutes.home,
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('이메일 또는 비밀번호를 확인해 주세요.')),
          );
      }
    } finally {
      if (mounted) setState(() => isSubmitting = false);
    }
  }

  void onForgotPasswordButtonPressed() {
    Navigator.pushNamed(context, PageRoutes.forgotPassword);
  }

  void onSignUpButtonPressed() {
    Navigator.pushNamed(context, PageRoutes.signUp);
  }
}
