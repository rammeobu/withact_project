import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/applicant_check_data_structure.dart';
import '../../future&component/layout/basic_layout.dart';
import '../../future&component/profile/profile_card_applicant.dart';
import 'applicant_select_position.dart';

class _ApplicantPositionNotifier extends Notifier<String> {
  @override
  String build() => 'all';
}

final applicantPositionProvider =
    NotifierProvider.autoDispose<_ApplicantPositionNotifier, String>(
      _ApplicantPositionNotifier.new,
    );

class ApplicantCheck extends ConsumerWidget {
  final List<String> position;
  final List<ApplicantItem>? applicants;
  ApplicantCheck({
    super.key,
    required this.position,
    List<ApplicantItem>? applicants,
  }) : applicants = applicants ?? [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final currentPosition = ref.watch(applicantPositionProvider);
    final displayList = currentPosition == 'all'
        ? applicants!
        : applicants!
              .where((applicant) => applicant.position == currentPosition)
              .toList();

    return BasicLayout(
      title: '지원자 확인',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 13, left: screenWidth * 0.049),
              child: Text('포지션별 지원자 선택', style: sectionTitleFont),
            ),
            ApplicantSelectPosition(position: position),
            Column(
              children: displayList
                  .map(
                    (applicantData) => Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.036,
                      ),
                      child: ProfileCardApplicant(
                        profileContent: [
                          applicantData.name,
                          applicantData.position,
                          applicantData.skill ?? '',
                        ],
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            PageRoutes.applicantProfile,
                            arguments: {
                              'name': applicantData.name,
                              'introduction': '',
                              'spec': applicantData.skill ?? '',
                              'applicationId': applicantData.id,
                            },
                          );
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: true,
    );
  }
}
