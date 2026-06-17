import 'package:flutter/material.dart';
import '../../future&component/component/no_scale.dart';
import '../../future&component/layout/default_container.dart';

class ApplicantProfileBody1 extends StatelessWidget {
  final String section;
  final String content;
  final ScrollController scrollController;
  const ApplicantProfileBody1({
    super.key,
    required this.section,
    required this.content,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section,
            style: TextStyle(
              fontSize: screenWidth * 0.041,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: DefaultContainer(
              color: const Color(0xffebedf0),
              width: screenWidth,
              height: 110,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.019),
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: scrollController,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: NoScale(
                      child: Text(
                        content,
                        style: TextStyle(fontSize: screenWidth * 0.036),
                      ),
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
