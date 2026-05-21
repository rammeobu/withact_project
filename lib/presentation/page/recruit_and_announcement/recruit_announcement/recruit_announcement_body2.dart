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
    final double screenWidth = MediaQuery.of(context).size.width;
    final List<String> preference = preferences ?? [];
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '우대사항',
                style: TextStyle(
                  fontSize: screenWidth * 0.058,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: DefaultContainer(
              color: const Color(0xffebedf0),
              width: screenWidth,
              height: 68,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.019),
                child: preference.isEmpty
                    ? Center(
                        child: Text(
                          '등록된 우대사항이 없습니다.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: screenWidth * 0.034,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...preference.map(
                              (prefer) => Padding(
                                padding: EdgeInsets.only(
                                  right: screenWidth * 0.019,
                                ),
                                child: Chip(
                                  label: Text('#$prefer'),
                                  visualDensity: VisualDensity.compact,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      screenWidth * 0.049,
                                    ),
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
