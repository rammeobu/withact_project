import 'package:flutter/material.dart';
import '../../future&component/layout/default_container.dart';

class AnnouncementEditBody2 extends StatelessWidget {
  final List<String> preferences;
  final ScrollController scrollController;
  final TextEditingController textEditingController;
  final Function(String) onPreferenceAdded;
  final Function(int) onDeletePreferenceButtonPressed;

  const AnnouncementEditBody2({
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
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: DefaultContainer(
              color: const Color(0xffebedf0),
              width: screenWidth,
              height: 68,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.019),
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        preferences.length,
                        (i) => Padding(
                          padding: EdgeInsets.only(right: screenWidth * 0.019),
                          child: Chip(
                            label: Text('#${preferences[i]}'),
                            onDeleted: () => onDeletePreferenceButtonPressed(i),
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.049,
                              ),
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
        ],
      ),
    );
  }
}
