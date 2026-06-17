import 'package:flutter/material.dart';
import '../../future&component/component/no_scale.dart';
import '../../future&component/layout/default_container.dart';

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
                      fontSize: screenWidth * 0.058,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (isRequired)
                    const Text(' *', style: TextStyle(color: Colors.red)),
                ],
              ),
              OutlinedButton(
                onPressed: onLoadButtonPressed,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  fixedSize: Size(screenWidth * 0.195, 44),
                  side: const BorderSide(width: 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(
                      screenWidth * 0.024,
                    ),
                  ),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  '불러오기',
                  style: TextStyle(
                    fontSize: screenWidth * 0.041,
                    fontWeight: FontWeight.w300,
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
                      color: Colors.black,
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
          ),
        ],
      ),
    );
  }
}
