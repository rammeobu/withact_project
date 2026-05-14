import 'package:flutter/material.dart';
import '../../future&component/layout/default_container.dart';

class RecruitAnnouncementBody2 extends StatelessWidget {
  final List<String>? preferences;
  final ScrollController scrollController;
  const RecruitAnnouncementBody2({
    super.key,
    this.preferences,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final List<String> preference = preferences ?? [];
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
                child: preference.isEmpty
                    ? const Center(
                        child: Text(
                          '등록된 우대사항이 없습니다.',
                          style: TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      )
                    : SingleChildScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...preference.map(
                              (prefer) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Chip(
                                  label: Text('#$prefer'),
                                  visualDensity: VisualDensity.compact,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
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
