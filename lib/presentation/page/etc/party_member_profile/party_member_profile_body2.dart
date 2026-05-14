import 'package:flutter/material.dart';
import '../../future&component/layout/default_container.dart';

class PartyMemberProfileBody2 extends StatelessWidget {
  final String section;
  final String content;
  final ScrollController scrollController;
  const PartyMemberProfileBody2({
    super.key,
    required this.section,
    required this.content,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section,
            style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.01),
            child: DefaultContainer(
              color: const Color(0xffebedf0),
              width: MediaQuery.of(context).size.width,
              height: screenHeight * 0.13,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Text(
                      content,
                      style: const TextStyle(fontSize: 15.0),
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
