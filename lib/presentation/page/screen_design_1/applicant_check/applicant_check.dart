import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/applicant_check_data_structure.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import '../../future&component/layout/basic_layout.dart';
import '../../future&component/profile/profile_card_applicant.dart';
import 'applicant_select_position.dart';

class ApplicantPositionNotifier extends Notifier<String> {
  @override
  String build() => '전체';

  void setPosition(String position) {
    state = position;
  }
}

final applicantPositionProvider =
    NotifierProvider.autoDispose<ApplicantPositionNotifier, String>(
      ApplicantPositionNotifier.new,
    );

class ApplicantCheck extends ConsumerStatefulWidget {
  final List<String> position;
  final int? partyId;
  const ApplicantCheck({super.key, required this.position, this.partyId});

  @override
  ConsumerState<ApplicantCheck> createState() => ApplicantCheckState();
}

class ApplicantCheckState extends ConsumerState<ApplicantCheck> {
  List<ApplicantItem> applicants = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchApplicants();
  }

  Future<void> fetchApplicants() async {
    final partyId = widget.partyId;
    if (partyId == null) {
      if (mounted) setState(() => isLoading = false);
      return;
    }
    try {
      final result =
          await ref.read(applyRepositoryProvider).getApplicants('$partyId');
      if (mounted) {
        setState(() {
          applicants = result;
          isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final currentPosition = ref.watch(applicantPositionProvider);
    final displayList = currentPosition == '전체'
        ? applicants
        : applicants
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
            ApplicantSelectPosition(position: widget.position),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: CircularProgressIndicator(color: appPrimaryColor),
                ),
              )
            else if (displayList.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    '지원자가 없습니다.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: screenWidth * 0.041,
                    ),
                  ),
                ),
              )
            else
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
