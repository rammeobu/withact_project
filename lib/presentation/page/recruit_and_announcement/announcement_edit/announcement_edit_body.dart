import 'package:flutter/material.dart';
import '../../future&component/layout/default_container.dart';

class AnnouncementEditBody extends StatelessWidget {
  final VoidCallback? onSearchButtonPressed;
  final String? content;
  final String section;
  final TextEditingController textEditingController;

  const AnnouncementEditBody({
    super.key,
    this.onSearchButtonPressed,
    this.content,
    required this.section,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                section,
                style: const TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              (section == '활동 이름')
                  ? OutlinedButton(
                      onPressed: onSearchButtonPressed,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        fixedSize: const Size(80, 35),
                        side: const BorderSide(width: 0.5),
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text(
                        '검색',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.008),
            child: DefaultContainer(
              color: const Color(0xffebedf0),
              width: MediaQuery.of(context).size.width,
              height: (section == '활동 이름')
                  ? screenHeight * 0.07
                  : screenHeight * 0.22,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: textEditingController,
                  selectionControls: EmptyTextSelectionControls(),
                  enableSuggestions: false,
                  autocorrect: false,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    hintText: (section == '활동 이름')
                        ? '$section을 검색하거나 직접 작성하세요.'
                        : '$section를 작성하세요.',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 17.0,
                    ),
                  ),
                  style: const TextStyle(fontSize: 17.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
