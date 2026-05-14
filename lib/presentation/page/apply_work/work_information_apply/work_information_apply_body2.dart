import 'package:flutter/material.dart';

import '../../future&component/component/person.dart';

class WorkInformationApplyBody2 extends StatefulWidget {
  final List<String> position;
  final void Function(String) onPersonPressed;
  const WorkInformationApplyBody2({
    super.key,
    required this.position,
    required this.onPersonPressed,
  });

  @override
  State<WorkInformationApplyBody2> createState() =>
      _WorkInformationApplyBody2State();
}

class _WorkInformationApplyBody2State extends State<WorkInformationApplyBody2> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.011),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.position
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
                          widget.onPersonPressed(e);
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
