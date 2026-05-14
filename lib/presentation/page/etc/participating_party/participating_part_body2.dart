import 'package:flutter/material.dart';

import '../../future&component/component/person.dart';

class ParticipatingPartBody2 extends StatelessWidget {
  final List<String> position;
  final void Function(String) onPersonPressed;
  const ParticipatingPartBody2({
    super.key,
    required this.position,
    required this.onPersonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.011),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: position
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          e,
                          style: const TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Person(
                        size: 60.0,
                        onPressed: () {
                          onPersonPressed(e);
                        },
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
