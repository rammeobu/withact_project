import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

import '../../../future&component/layout/default_container.dart';
import 'recruit_card_button.dart';
import 'recruit_card_middle.dart';

class RecruitCard extends StatelessWidget {
  final String? poster;
  final String name;
  final List<String> timePlace;
  final String applyStatus;
  final VoidCallback onDetailButtonPressed;
  final VoidCallback onAnnouncementManageButtonPressed;
  final VoidCallback onCheckApplicantButtonPressed;
  const RecruitCard({
    super.key,
    this.poster,
    required this.name,
    required this.timePlace,
    required this.applyStatus,
    required this.onDetailButtonPressed,
    required this.onAnnouncementManageButtonPressed,
    required this.onCheckApplicantButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.036),
      child: SizedBox(
        height: 506,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(screenWidth * 0.049),
          ),
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: DefaultContainer(
                      height: 231,
                      width: screenWidth * 0.316,
                      color: posterColor,
                      child: (poster != null && poster!.startsWith('http'))
                          ? Image.network(
                              poster!,
                              fit: BoxFit.cover,
                              cacheWidth: 400,
                            )
                          : const Center(child: Text('포스터')),
                    ),
                  ),
                ),
                RecruitCardMiddle(
                  name: name,
                  timePlace: timePlace,
                  applyStatus: applyStatus,
                ),
                Expanded(
                  flex: 2,
                  child: RecruitCardButton(
                    applyStatus: applyStatus,
                    onDetailButtonPressed: onDetailButtonPressed,
                    onAnnouncementManageButtonPressed:
                        onAnnouncementManageButtonPressed,
                    onCheckApplicantButtonPressed:
                        onCheckApplicantButtonPressed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
