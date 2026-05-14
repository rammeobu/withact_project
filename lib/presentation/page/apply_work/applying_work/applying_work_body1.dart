import 'package:flutter/material.dart';
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
    const TextStyle commonTextStyle = TextStyle(
      fontSize: 17.0,
      height: 1.4,
      letterSpacing: 0.0,
      color: Colors.black,
    );

    const StrutStyle commonStrutStyle = StrutStyle(
      fontSize: 17.0,
      height: 1.4,
      forceStrutHeight: true,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                section ?? '',
                style: const TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              OutlinedButton(
                onPressed: onEditButtonPressed,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  fixedSize: const Size(60, 35),
                  side: const BorderSide(width: 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10.0),
                  ),
                  backgroundColor: editingMode
                      ? const Color(0xff5764f0)
                      : const Color(0xff1cb879),
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  editingMode ? '저장' : '수정',
                  style: const TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: DefaultContainer(
              color: const Color(0xffebedf0),
              width: MediaQuery.of(context).size.width,
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: editingMode
                    ? TextField(
                        controller: textController,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        style: commonTextStyle,
                        strutStyle: commonStrutStyle,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.only(top: 0.0),
                          hint: Text('내용을 입력해주세요.'),
                          hintStyle: TextStyle(
                            fontSize: 16.0,
                            color: Color(0x4D7F7F7F),
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
