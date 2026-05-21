import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

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
    required this.onApplyButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 169,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(screenWidth * 0.049),
        ),
        color: cardColor,
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.029),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: DefaultContainer(
                          height: screenWidth * 0.170,
                          width: screenWidth * 0.170,
                          color: posterColor,
                          child: Center(
                            child:
                                (poster != null && poster!.startsWith('http'))
                                ? Image.network(
                                    poster!,
                                    fit: BoxFit.cover,
                                    cacheWidth: 300,
                                  )
                                : const Text('포스터'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.049),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Text(
                                partyName,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.049,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Text(
                                workName,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.041,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                          top: const BorderSide(width: 0.5, color: Colors.grey),
                          right: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: appPrimaryColor,
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
                          top: const BorderSide(width: 0.5, color: Colors.grey),
                          right: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: appPrimaryColor,
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
                          top: const BorderSide(width: 0.5, color: Colors.grey),
                        ),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: appPrimaryColor,
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
