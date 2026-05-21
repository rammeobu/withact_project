import 'package:flutter/material.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/recruit_data_structures.dart';
import '../../future&component/layout/basic_layout.dart';

class RecruitManageSelect extends StatelessWidget {
  final List<RecruitItem> recruitList;
  RecruitManageSelect({super.key, List<RecruitItem>? recruitList})
    : recruitList =
          recruitList ??
          [
            const RecruitItem(
              name: '활동 1',
              timePlace: ['시간', '장소'],
              applyStatus: '지원 중',
              poster: '',
            ),
            const RecruitItem(
              name: '활동 2',
              timePlace: ['시간', '장소'],
              applyStatus: '지원 중',
              poster: '',
            ),
            const RecruitItem(
              name: '활동 3',
              timePlace: ['시간', '장소'],
              applyStatus: '지원 중',
              poster: '',
            ),
          ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return BasicLayout(
      title: '모집정보 관리',
      body: Padding(
        padding: EdgeInsets.only(
          top: 13,
          left: screenWidth * 0.036,
          right: screenWidth * 0.036,
        ),
        child: ListView.separated(
          itemCount: recruitList.length,
          separatorBuilder: (context, i) =>
              Container(height: 0.5, color: const Color(0xFFBDBDBD)),
          itemBuilder: (context, i) {
            final recruit = recruitList[i];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  PageRoutes.recruitAnnouncement,
                  arguments: {
                    'workName': recruit.name,
                    'partyNameIntroduction': '',
                    'position': <String>[],
                    'preferences': null,
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      recruit.name,
                      style: TextStyle(
                        fontSize: screenWidth * 0.041,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: appPrimaryColor,
                      size: screenWidth * 0.058,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: true,
    );
  }
}
