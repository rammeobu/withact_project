import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import '../../future&component/layout/default_container.dart';

class ApplyingWorkBody extends StatelessWidget {
  final String? section;
  final String? content;
  final bool editingMode;
  final VoidCallback onEditButtonPressed;
  final TextEditingController textController;
  final ScrollController scrollController;

  const ApplyingWorkBody({
    super.key,
    required this.section,
    required this.content,
    required this.editingMode,
    required this.onEditButtonPressed,
    required this.textController,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final TextStyle commonTextStyle = TextStyle(
      fontSize: screenWidth * 0.041,
      height: 1.4,
      letterSpacing: 0.0,
      color: Colors.black,
    );
    final StrutStyle commonStrutStyle = StrutStyle(
      fontSize: screenWidth * 0.041,
      height: 1.4,
      forceStrutHeight: true,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                section ?? '',
                style: TextStyle(
                  fontSize: screenWidth * 0.058,
                  fontWeight: FontWeight.w500,
                ),
              ),
              OutlinedButton(
                onPressed: onEditButtonPressed,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  fixedSize: Size(screenWidth * 0.146, 41),
                  side: const BorderSide(width: 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(
                      screenWidth * 0.024,
                    ),
                  ),
                  backgroundColor: editingMode
                      ? appPrimaryColor
                      : const Color(0xff1cb879),
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  editingMode ? '저장' : '수정',
                  style: TextStyle(
                    fontSize: screenWidth * 0.041,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: DefaultContainer(
              color: const Color(0xffebedf0),
              width: screenWidth,
              height: 150,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.019),
                child: editingMode
                    ? TextField(
                        controller: textController,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        style: commonTextStyle,
                        strutStyle: commonStrutStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.only(top: 0.0),
                          hint: const Text('내용을 입력해주세요.'),
                          hintStyle: TextStyle(
                            fontSize: screenWidth * 0.039,
                            color: const Color(0x4D7F7F7F),
                            letterSpacing: 0.0,
                          ),
                        ),
                      )
                    : Scrollbar(
                        controller: scrollController,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Text(
                            content ?? '',
                            style: commonTextStyle,
                            strutStyle: commonStrutStyle,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
