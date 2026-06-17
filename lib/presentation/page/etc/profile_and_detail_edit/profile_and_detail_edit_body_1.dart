import 'package:flutter/material.dart';
import '../../future&component/component/no_scale.dart';
import '../../future&component/layout/default_container.dart';

class ProfileAndDetailEditBody1 extends StatelessWidget {
  final String section;
  final TextEditingController controller;

  const ProfileAndDetailEditBody1({
    super.key,
    required this.section,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section,
            style: TextStyle(
              fontSize: screenWidth * 0.051,
              fontWeight: FontWeight.w500,
            ),
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
                    controller: controller,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: '$section 내용 입력 혹은 불러오기',
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
