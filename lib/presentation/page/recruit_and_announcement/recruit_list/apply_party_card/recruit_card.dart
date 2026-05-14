import 'package:flutter/material.dart';

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
    return SizedBox(
      height: 120.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20.0),
          ),
          color: const Color(0xFFFDFDFD),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Align(
                    alignment: const Alignment(0, 0),
                    child: DefaultContainer(
                      height: 70,
                      width: 70,
                      color: const Color(0xffe3e5e9),
                      child: (poster != null && poster!.startsWith('http'))
                          ? Image.network(poster!, fit: BoxFit.cover)
                          : const Center(child: Text('포스터')),
                    ),
                  ),
                ),
                RecruitCardMiddle(name: name, timePlace: timePlace),
                Expanded(
                  flex: 7,
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
