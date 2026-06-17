import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';
import '../../future&component/component/no_scale.dart';

class ActivityRecruitBody extends StatelessWidget {
  final VoidCallback? onSearchButtonPressed;
  final String? content;
  final String section;
  final TextEditingController textEditingController;
  final bool isRequired;

  const ActivityRecruitBody({
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
    final bool isName = section == '활동 이름';
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
                      fontSize: screenWidth * 0.051,
                      fontWeight: FontWeight.w700,
                      color: cardInk,
                    ),
                  ),
                  if (isRequired)
                    const Text(' *', style: TextStyle(color: Colors.red)),
                ],
              ),
              if (isName)
                TextButton.icon(
                  onPressed: onSearchButtonPressed,
                  icon: Icon(Icons.search_rounded, size: screenWidth * 0.042),
                  label: Text(
                    '검색',
                    style: TextStyle(
                      fontSize: screenWidth * 0.034,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: appPrimaryColor,
                    backgroundColor: cardChipBg,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.035,
                    ),
                    minimumSize: const Size(0, 38),
                    shape: const StadiumBorder(),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              width: double.infinity,
              height: isName ? 56 : 186,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                border: Border.all(color: const Color(0xFFE0E3E8)),
              ),
              padding: EdgeInsets.all(screenWidth * 0.035),
              child: NoScale(
                child: TextField(
                  controller: textEditingController,
                  readOnly: isName,
                  enableSuggestions: false,
                  autocorrect: false,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    hintText: isName
                        ? '검색으로 활동을 선택하세요.'
                        : '$section를 작성하세요.',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: screenWidth * 0.041,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: screenWidth * 0.041,
                    color: cardInk,
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
