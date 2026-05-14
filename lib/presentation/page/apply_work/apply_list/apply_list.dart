import 'package:flutter/material.dart';
import '../../future&component/layout/basic_layout.dart';
import 'apply_party_card/apply_party_card.dart';

class ApplyList extends StatefulWidget {
  List<dynamic>? apply = [
    [
      '활동 1',
      ['시간', '장소'],
      '지원 중',
      '',
    ],
    [
      '활동 2',
      ['시간', '장소'],
      '지원 중',
      '',
    ],
    [
      '활동 3',
      ['시간', '장소'],
      '지원 중',
      '',
    ],
    [
      '활동 4',
      ['시간', '장소'],
      '지원 중',
      '',
    ],
    [
      '활동 5',
      ['시간', '장소'],
      '지원 중',
      '',
    ],
    [
      '활동 6',
      ['시간', '장소'],
      '지원 중',
      '',
    ],
    [
      '활동 7',
      ['시간', '장소'],
      '지원 중',
      '',
    ],
  ];
  ApplyList({super.key});

  @override
  State<ApplyList> createState() => _ApplyListState();
}

class _ApplyListState extends State<ApplyList> {
  @override
  Widget build(BuildContext context) {
    return BasicLayout(
      title: '파티 지원 목록',
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: Column(
              children: widget.apply!
                  .map(
                    (apply) => Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ApplyPartyCard(
                        name: apply[0],
                        timePlace: apply[1],
                        applyStatus: apply[2],
                        poster: apply[3],
                        onDetailButtonPressed: () {
                          print('${apply[0]} 활동 설명으로 이동');
                        },
                        onCheckProfileButtonPressed: () {
                          print('${apply[0]} 지원서 확인으로 이동');
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
      bottomNavigationBar: true,
    );
  }
}
