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
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '우대사항',
                style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.008),
            child: DefaultContainer(
              color: const Color(0xffebedf0),
              width: MediaQuery.of(context).size.width,
              height: screenHeight * 0.08,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        preferences.length,
                        (i) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Chip(
                            label: Text('#${preferences[i]}'),
                            onDeleted: () => onDeletePreferenceButtonPressed(i),
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
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
                          decoration: const InputDecoration(
                            hintText: '#추가',
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                          ),
                          style: const TextStyle(fontSize: 13.0),
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
