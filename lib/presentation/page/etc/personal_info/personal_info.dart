import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _NewPasswordMatchNotifier extends Notifier<bool> {
  @override
  bool build() => true;
}

final newPasswordMatchProvider =
    NotifierProvider.autoDispose<_NewPasswordMatchNotifier, bool>(
      _NewPasswordMatchNotifier.new,
    );

class PersonalInfo extends ConsumerStatefulWidget {
  final String loginId;
  const PersonalInfo({super.key, this.loginId = ''});

  @override
  ConsumerState<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends ConsumerState<PersonalInfo> {
  late TextEditingController loginIdTextController;
  late TextEditingController currentPasswordTextController;
  late TextEditingController newPasswordTextController;
  late TextEditingController confirmPasswordTextController;

  @override
  void initState() {
    super.initState();
    loginIdTextController = TextEditingController(text: widget.loginId);
    currentPasswordTextController = TextEditingController();
    newPasswordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();

    newPasswordTextController.addListener(() {
      ref.read(newPasswordMatchProvider.notifier).state =
          newPasswordTextController.text == confirmPasswordTextController.text;
    });
    confirmPasswordTextController.addListener(() {
      ref.read(newPasswordMatchProvider.notifier).state =
          newPasswordTextController.text == confirmPasswordTextController.text;
    });
  }

  @override
  void dispose() {
    loginIdTextController.dispose();
    currentPasswordTextController.dispose();
    newPasswordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool passwordMatch = ref.watch(newPasswordMatchProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6D4C41),
        title: Text(
          '개인정보 관리',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: screenWidth * 0.044,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            sectionHeader('계정 정보', screenWidth),
            fieldRow(
              '이메일',
              loginIdTextController,
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

            sectionHeader('비밀번호 변경', screenWidth),
            fieldRow(
              '현재 비밀번호',
              currentPasswordTextController,
              '현재 비밀번호를 입력해 주세요.',
              screenWidth,
              isObscure: true,
            ),
            fieldRow(
              '새 비밀번호',
              newPasswordTextController,
              '새 비밀번호를 입력해 주세요.',
              screenWidth,
              isObscure: true,
            ),
            fieldRow(
              '비밀번호 확인',
              confirmPasswordTextController,
              '새 비밀번호를 다시 한 번 입력해 주세요.',
              screenWidth,
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

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.049,
                vertical: 42,
              ),
              child: OutlinedButton(
                onPressed: onSaveButtonPressed,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 63),
                  side: const BorderSide(width: 0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.024),
                  ),
                ),
                child: Text(
                  '저장',
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
            width: width * 0.28,
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

  void onEmailAuthButtonPressed() {
    // TODO: 입력된 이메일이 유효하며 가입 시 사용한 이메일과 일치할 경우 해당 이메일로 인증 코드를 발송하는 기능 구현 (백엔드와 협의 필요)
  }

  void onSaveButtonPressed() {
    final bool anyPasswordFilled =
        currentPasswordTextController.text.isNotEmpty ||
        newPasswordTextController.text.isNotEmpty ||
        confirmPasswordTextController.text.isNotEmpty;
    if (anyPasswordFilled) {
      if (currentPasswordTextController.text.isEmpty ||
          newPasswordTextController.text.isEmpty ||
          confirmPasswordTextController.text.isEmpty) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                '비밀번호를 변경하려면 현재 비밀번호, 새 비밀번호, 비밀번호 확인을 모두 입력해 주세요.',
              ),
            ),
          );
        return;
      }
      if (newPasswordTextController.text !=
          confirmPasswordTextController.text) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(content: Text('새 비밀번호가 일치하지 않습니다.')));
        return;
      }
    }
    Navigator.pop(context);
  }
}
