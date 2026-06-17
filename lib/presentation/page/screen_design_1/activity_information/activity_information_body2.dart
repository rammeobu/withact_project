import 'package:flutter/material.dart';

import '../../future&component/component/person.dart';

class ActivityInformationBody2 extends StatelessWidget {
  final List<String> position;
  final List<int> currents;
  final List<bool>? positionOccupy;
  final void Function(String) onPersonPressed;
  const ActivityInformationBody2({
    super.key,
    required this.position,
    required this.onPersonPressed,
    this.currents = const [],
    this.positionOccupy,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final members = <String>[];
    for (int i = 0; i < position.length; i++) {
      final count = i < currents.length ? currents[i] : 1;
      for (int k = 0; k < count; k++) {
        members.add(position[i]);
      }
    }
    return Padding(
      padding: const EdgeInsets.only(top: 9),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: members.map((roleName) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.012),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      roleName,
                      style: TextStyle(
                        fontSize: screenWidth * 0.032,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Person(
                    size: screenWidth * 0.146,
                    onPressed: () => onPersonPressed(roleName),
                    positionOccupied: true,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
