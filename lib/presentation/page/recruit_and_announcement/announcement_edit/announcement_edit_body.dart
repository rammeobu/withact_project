import 'package:flutter/material.dart';
import '../../future&component/component/no_scale.dart';
import '../../future&component/layout/default_container.dart';

class AnnouncementEditBody extends StatelessWidget {
  final VoidCallback? onSearchButtonPressed;
  final String? content;
  final String section;
  final TextEditingController textEditingController;
  final bool isRequired;

  const AnnouncementEditBody({
    super.key,
    this.onSearchButtonPressed,
    this.content,
    required this.section,
    required this.textEditingController,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    section,
                    style: TextStyle(
                      fontSize: screenWidth * 0.058,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (isRequired)
                    const Text(' *', style: TextStyle(color: Colors.red)),
                ],
              ),
              (section == '활동 이름')
                  ? OutlinedButton(
                      onPressed: onSearchButtonPressed,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        fixedSize: Size(screenWidth * 0.195, 44),
                        side: const BorderSide(width: 0.5),
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: Text(
                        '검색',
                        style: TextStyle(
                          fontSize: screenWidth * 0.036,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: DefaultContainer(
              color: const Color(0xffebedf0),
              width: screenWidth,
              height: (section == '활동 이름') ? 59 : 186,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.019),
                child: NoScale(
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
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.041,
                      ),
                    ),
                    style: TextStyle(fontSize: screenWidth * 0.041),
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
