import 'package:flutter/material.dart';

import '../../future&component/component/person.dart';

class ActivityInformationApplyBody2 extends StatelessWidget {
  final List<String> position;
  final List<bool>? positionOccupy;
  final void Function(String) onPersonPressed;
  const ActivityInformationApplyBody2({
    super.key,
    required this.position,
    required this.onPersonPressed,
    this.positionOccupy,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 9),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: position
              .asMap()
              .entries
              .map(
                (positionEntry) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.012,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          positionEntry.value,
                          style: TextStyle(
                            fontSize: screenWidth * 0.032,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Person(
                        size: screenWidth * 0.146,
                        onPressed: () => onPersonPressed(positionEntry.value),
                        positionOccupied:
                            positionOccupy != null &&
                                positionEntry.key < positionOccupy!.length
                            ? positionOccupy![positionEntry.key]
                            : true,
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
