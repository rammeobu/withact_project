import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

class ActivityRecruitBody2 extends StatelessWidget {
  final List<String> preferences;
  final ScrollController scrollController;
  final TextEditingController textEditingController;
  final Function(String) onPreferenceAdded;
  final Function(int) onDeletePreferenceButtonPressed;

  const ActivityRecruitBody2({
    super.key,
    required this.preferences,
    required this.scrollController,
    required this.textEditingController,
    required this.onPreferenceAdded,
    required this.onDeletePreferenceButtonPressed,
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
              Text(
                '우대사항',
                style: TextStyle(
                  fontSize: screenWidth * 0.058,
                  fontWeight: FontWeight.w800,
                  color: cardInk,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Material(
              color: cardColor,
              elevation: 2,
              shadowColor: Colors.black26,
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: screenWidth,
                height: 68,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(
                          preferences.length,
                          (i) => Padding(
                            padding: EdgeInsets.only(
                              right: screenWidth * 0.019,
                            ),
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 12,
                                right: 6,
                                top: 6,
                                bottom: 6,
                              ),
                              decoration: BoxDecoration(
                                color: cardChipBg,
                                borderRadius: BorderRadius.circular(
                                  screenWidth * 0.05,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '#${preferences[i]}',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.034,
                                      fontWeight: FontWeight.w600,
                                      color: appPrimaryColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: InkWell(
                                      onTap: () =>
                                          onDeletePreferenceButtonPressed(i),
                                      borderRadius: BorderRadius.circular(20),
                                      child: Icon(
                                        Icons.close,
                                        size: screenWidth * 0.04,
                                        color: appPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        IntrinsicWidth(
                          stepWidth: 100.0,
                          child: TextField(
                            controller: textEditingController,
                            onSubmitted: (preference) {
                              final text = preference.trim();
                              if (text.isNotEmpty) {
                                onPreferenceAdded(text);
                              }
                            },
                            decoration: InputDecoration(
                              hintText: '#추가',
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.010,
                              ),
                            ),
                            style: TextStyle(fontSize: screenWidth * 0.032),
                          ),
                        ),
                      ],
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
