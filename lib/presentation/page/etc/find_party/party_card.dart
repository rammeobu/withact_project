import 'package:flutter/material.dart';

import '../../future&component/layout/default_container.dart';

class PartyCard extends StatelessWidget {
  final String partyName;
  final String? poster;
  final String workName;
  final VoidCallback? onPartyLeaderInformationCheckButtonPressed;
  final VoidCallback? onRecruitAnnouncementCheckButtonPressed;
  final VoidCallback? onApplyButtonPressed;
  const PartyCard({
    super.key,
    required this.partyName,
    this.poster,
    required this.workName,
    required this.onPartyLeaderInformationCheckButtonPressed,
    required this.onRecruitAnnouncementCheckButtonPressed,
    required this.onApplyButtonPressed
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.2,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20.0),
        ),
        color: const Color(0xFFFDFDFD),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: const Alignment(0, 0),
                        child: DefaultContainer(
                          height: 70,
                          width: 70,
                          color: const Color(0xffe3e5e9),
                          child: Center(
                            child:
                            (poster != null && poster!.startsWith('http'))
                                ? Image.network(poster!, fit: BoxFit.cover)
                                : const Text('포스터'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: screenHeight * 0.008,
                              ),
                              child: Text(
                                partyName,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.008,
                        ),
                        child: Text(
                          workName,
                          style: const TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),],
                            ),
                      ))],
                        ),
                      ),
                    ),
            Expanded(
              flex: 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.fromLTRB(
                          top: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                          right: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF5764F0),
                        ),
                        onPressed: onPartyLeaderInformationCheckButtonPressed,
                        child: const Text(
                          '파티장 정보',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.fromLTRB(
                          top: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                          right: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF5764F0),
                        ),
                        onPressed: onRecruitAnnouncementCheckButtonPressed,
                        child: const Text(
                          '모집 공고',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.fromLTRB(
                          top: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF5764F0),
                        ),
                        onPressed: onApplyButtonPressed,
                        child: const Text(
                          '지원하기',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}