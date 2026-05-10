import 'package:flutter/material.dart';

import '../../future&component/component/person.dart';

class RecruitAnnouncementBody3 extends StatefulWidget {
  final List<String> position;
  final ScrollController primaryScrollController;
  const RecruitAnnouncementBody3({
    super.key,
    required this.primaryScrollController,
    required this.position,
  });

  @override
  State<RecruitAnnouncementBody3> createState() =>
      _RecruitAnnouncementBody3State();
}

class _RecruitAnnouncementBody3State extends State<RecruitAnnouncementBody3> {
  final ScrollController horizontalScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '모집역할/인원',
          style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w800),
        ),
        Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.011),
          child: SingleChildScrollView(
            controller: horizontalScrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget.position.map((pos) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          pos,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Person(size: 50.0),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
