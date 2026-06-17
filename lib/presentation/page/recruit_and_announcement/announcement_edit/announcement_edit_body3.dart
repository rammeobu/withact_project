import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

import '../../future&component/component/person.dart';

class AnnouncementEditBody3 extends StatelessWidget {
  final ScrollController primaryScrollController;
  final ScrollController horizontalScrollController;
  final List<TextEditingController> textEditingControllers;
  final VoidCallback onAddPositionButtonPressed;
  final void Function(int) onDeletePositionButtonPressed;
  final List<String> positions;
  const AnnouncementEditBody3({
    super.key,
    required this.primaryScrollController,
    required this.horizontalScrollController,
    required this.textEditingControllers,
    required this.onAddPositionButtonPressed,
    required this.onDeletePositionButtonPressed,
    required this.positions,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '모집역할/인원',
                  style: TextStyle(
                    fontSize: screenWidth * 0.058,
                    fontWeight: FontWeight.w800,
                    color: cardInk,
                  ),
                ),
                const Text(' *', style: TextStyle(color: Colors.red)),
              ],
            ),
            IconButton(
              onPressed: onAddPositionButtonPressed,
              color: appPrimaryColor,
              icon: Icon(Icons.add_circle_outline, size: screenWidth * 0.073),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 9),
          child: SingleChildScrollView(
            controller: horizontalScrollController,
            scrollDirection: Axis.horizontal,
            child: positions.isEmpty
                ? SizedBox(
                    height: 150,
                    width: screenWidth * 0.927,
                    child: const Center(
                      child: Text(
                        '모집 역할을 추가해주세요.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                : Row(
                    children: positions.asMap().entries.map((entry) {
                      final int i = entry.key;
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.012,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: textEditingControllers[i],
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: '직군',
                                    hintStyle: TextStyle(
                                      fontSize: screenWidth * 0.036,
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.036,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Person(size: screenWidth * 0.122),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(width: 0.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    screenWidth * 0.049,
                                  ),
                                ),
                                backgroundColor: const Color(0xFFF34343),
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () => onDeletePositionButtonPressed(i),
                              child: Text(
                                '제거',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.036,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ),
      ],
    );
  }
}
