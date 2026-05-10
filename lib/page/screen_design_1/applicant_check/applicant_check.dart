import 'package:flutter/material.dart';
import '../../future&component/layout/basic_layout.dart';
import '../../future&component/profile/profile_card_applicant.dart';
import 'applicant_select_position.dart';

class ApplicantCheck extends StatefulWidget {
  final List<String> position;
  List<List<String>>? applicants = [
    ['홍길동', 'PM', 'react'],
    ['이순신', 'FE', 'flutter'],
    ['임꺽정', 'BE', 'spring'],
    ['유성룡', 'BE', 'FastAPI'],
    ['이몽룡', 'FE', 'typescript'],
    ['김종서', 'BE', 'javascript'],
  ];
  ApplicantCheck({super.key, required this.position});

  @override
  State<ApplicantCheck> createState() => _ApplicantCheckState();
}

class _ApplicantCheckState extends State<ApplicantCheck> {
  String currentPosition = 'all';
  @override
  Widget build(BuildContext context) {
    final displayList = currentPosition == 'all'
        ? widget.applicants!
        : widget.applicants!
              .where((applicant) => applicant[1] == currentPosition)
              .toList();

    return BasicLayout(
      title: '지원자 확인',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15.0, left: 20.0),
              child: Text(
                '포지션별 지원자 선택',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
              ),
            ),
            ApplicantSelectPosition(
              position: widget.position,
              currentPosition: currentPosition,
              onChanged: (changedPosition) {
                setState(() {
                  currentPosition = changedPosition;
                });
              },
            ),
            Column(
              children: displayList
                  .map(
                    (applicantData) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ProfileCardApplicant(
                        profileContent: applicantData,
                        onTap: () {
                          print('선택: ${applicantData[0]}');
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
