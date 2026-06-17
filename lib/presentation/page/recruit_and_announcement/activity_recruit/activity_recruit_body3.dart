import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

class ActivityRecruitBody3 extends StatelessWidget {
  final ScrollController primaryScrollController;
  final ScrollController horizontalScrollController;
  final List<TextEditingController> textEditingControllers;
  final VoidCallback onAddPositionButtonPressed;
  final void Function(int) onDeletePositionButtonPressed;
  final void Function(int) onIncrementCountButtonPressed;
  final void Function(int) onDecrementCountButtonPressed;
  final List<String> positions;
  final List<int> counts;
  const ActivityRecruitBody3({
    super.key,
    required this.primaryScrollController,
    required this.horizontalScrollController,
    required this.textEditingControllers,
    required this.onAddPositionButtonPressed,
    required this.onDeletePositionButtonPressed,
    required this.onIncrementCountButtonPressed,
    required this.onDecrementCountButtonPressed,
    required this.positions,
    required this.counts,
  });

  Widget _counterButton(IconData icon, double screenWidth, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: screenWidth * 0.09,
        height: screenWidth * 0.09,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: cardChipBg,
        ),
        child: Icon(icon, size: screenWidth * 0.042, color: appPrimaryColor),
      ),
    );
  }

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
                  ),
                ),
                const Text(' *', style: TextStyle(color: Colors.red)),
              ],
            ),
            IconButton(
              onPressed: onAddPositionButtonPressed,
              icon: Icon(
                Icons.add_circle_outline,
                size: screenWidth * 0.073,
                color: appPrimaryColor,
              ),
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
                    height: 120,
                    width: screenWidth * 0.927,
                    child: const Center(
                      child: Text(
                        '모집 역할을 추가해주세요.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: positions.asMap().entries.map((entry) {
                      final int i = entry.key;
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.012,
                        ),
                        child: Container(
                          width: screenWidth * 0.42,
                          padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(screenWidth * 0.04),
                            border: Border.all(color: const Color(0xFFE0E3E8)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: textEditingControllers[i],
                                      decoration: InputDecoration(
                                        hintText: '직군',
                                        hintStyle: TextStyle(
                                          fontSize: screenWidth * 0.036,
                                          color: Colors.grey,
                                        ),
                                        border: const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Color(0xFFE0E3E8)),
                                        ),
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: appPrimaryColor),
                                        ),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(vertical: 8),
                                      ),
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.038,
                                        fontWeight: FontWeight.w700,
                                        color: cardInk,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => onDeletePositionButtonPressed(i),
                                    customBorder: const CircleBorder(),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Icon(
                                        Icons.close,
                                        size: screenWidth * 0.05,
                                        color: const Color(0xFFB7BDC6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _counterButton(
                                      Icons.remove,
                                      screenWidth,
                                      () {
                                        HapticFeedback.selectionClick();
                                        onDecrementCountButtonPressed(i);
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.03,
                                      ),
                                      child: AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 200),
                                        transitionBuilder: (child, animation) =>
                                            FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            ),
                                        child: Text(
                                          '${i < counts.length ? counts[i] : 1}명',
                                          key: ValueKey(
                                            i < counts.length ? counts[i] : 1,
                                          ),
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.04,
                                            fontWeight: FontWeight.w700,
                                            color: cardInk,
                                          ),
                                        ),
                                      ),
                                    ),
                                    _counterButton(
                                      Icons.add,
                                      screenWidth,
                                      () {
                                        HapticFeedback.selectionClick();
                                        onIncrementCountButtonPressed(i);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
