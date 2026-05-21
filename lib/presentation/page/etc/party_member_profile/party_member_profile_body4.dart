import 'package:flutter/material.dart';

import '../../future&component/component/person.dart';

class PartyMemberProfileBody4 extends StatelessWidget {
  final List<String> position;
  final void Function(String) onPersonPressed;
  final ScrollController scrollController;
  const PartyMemberProfileBody4({
    super.key,
    required this.position,
    required this.onPersonPressed,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 9),
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: position
              .map(
                (positionName) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.012,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          positionName,
                          style: TextStyle(
                            fontSize: screenWidth * 0.032,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Person(
                        size: screenWidth * 0.146,
                        onPressed: () {
                          onPersonPressed(positionName);
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
