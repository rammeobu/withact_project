import 'package:flutter/material.dart';

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
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '모집역할/인원',
              style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w800),
            ),
            IconButton(
              onPressed: onAddPositionButtonPressed,
              icon: const Icon(Icons.add_circle_outline, size: 30.0),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.011),
          child: SingleChildScrollView(
            controller: horizontalScrollController,
            scrollDirection: Axis.horizontal,
            child: positions.isEmpty
                ? SizedBox(
                    height: 130,
                    width: MediaQuery.of(context).size.width - 30,
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
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: textEditingControllers[i],
                                  textAlign: TextAlign.center,
                                  onChanged: (pos) {
                                    positions[i] = pos;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: '직군',
                                    hintStyle: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 4.0,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Person(size: 50.0),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(width: 0.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    20.0,
                                  ),
                                ),
                                backgroundColor: const Color(0xFFF34343),
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () => onDeletePositionButtonPressed(i),
                              child: const Text(
                                '제거',
                                style: TextStyle(
                                  fontSize: 15.0,
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
