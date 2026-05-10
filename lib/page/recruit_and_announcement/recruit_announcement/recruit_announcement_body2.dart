import 'package:flutter/material.dart';
import '../../future&component/layout/default_container.dart';

class RecruitAnnouncementBody2 extends StatefulWidget {
  final List<String>? preferences;
  const RecruitAnnouncementBody2({super.key, this.preferences});

  @override
  State<RecruitAnnouncementBody2> createState() =>
      _RecruitAnnouncementBody2State();
}

class _RecruitAnnouncementBody2State extends State<RecruitAnnouncementBody2> {
  late ScrollController _scrollController;
  List<String> preferences = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    preferences = widget.preferences ?? [];

    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0.0);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
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
                child: preferences.isEmpty
                    ? const Center(
                        child: Text(
                          '등록된 우대사항이 없습니다.',
                          style: TextStyle(
                            color: Colors.grey, // 살짝 더 부드러운 회색
                            fontSize: 14.0,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...preferences.map(
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
