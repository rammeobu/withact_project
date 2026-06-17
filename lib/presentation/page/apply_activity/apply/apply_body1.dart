import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';
import '../../future&component/component/no_scale.dart';

class ApplyBody extends StatelessWidget {
  final String? section;
  final String? content;
  final VoidCallback onLoadButtonPressed;
  final TextEditingController textController;
  final bool isRequired;

  const ApplyBody({
    super.key,
    required this.section,
    required this.content,
    required this.onLoadButtonPressed,
    required this.textController,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    section ?? '',
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
              TextButton.icon(
                onPressed: onLoadButtonPressed,
                icon: Icon(Icons.download_rounded, size: screenWidth * 0.042),
                label: Text(
                  '불러오기',
                  style: TextStyle(
                    fontSize: screenWidth * 0.034,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: appPrimaryColor,
                  backgroundColor: cardChipBg,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
                  minimumSize: const Size(0, 38),
                  shape: const StadiumBorder(),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                border: Border.all(color: const Color(0xFFE0E3E8)),
              ),
              padding: EdgeInsets.all(screenWidth * 0.035),
              child: NoScale(
                child: TextField(
                  controller: textController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  style: TextStyle(
                    fontSize: screenWidth * 0.041,
                    height: 1.4,
                    letterSpacing: 0.0,
                    color: cardInk,
                  ),
                  strutStyle: StrutStyle(
                    fontSize: screenWidth * 0.041,
                    height: 1.4,
                    forceStrutHeight: true,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.only(top: 0.0),
                    hint: const Text('내용을 입력해주세요.'),
                    hintStyle: TextStyle(
                      fontSize: screenWidth * 0.039,
                      color: Colors.grey,
                      letterSpacing: 0.0,
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
