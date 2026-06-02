import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/data/providers/repository_providers.dart';

class DisbandDoubleCheck extends ConsumerWidget {
  final int partyId;
  const DisbandDoubleCheck({super.key, required this.partyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.061),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.question_mark_rounded,
                      size: screenWidth * 0.487,
                      color: Colors.black,
                    ),
                    Text(
                      '파티 해체',
                      style: TextStyle(
                        fontSize: screenWidth * 0.085,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 23),
                      child: Text(
                        '정말로 파티를\n 해체하시겠습니까?',
                        style: TextStyle(fontSize: screenWidth * 0.049),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 23),
                  child: OutlinedButton(
                    onPressed: () => onDisbandConfirmButtonPressed(context, ref),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      minimumSize: Size(screenWidth * 0.365, 69),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(
                          screenWidth * 0.055,
                        ),
                      ),
                    ),
                    child: Text(
                      '예',
                      style: TextStyle(
                        fontSize: screenWidth * 0.058,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 23),
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      minimumSize: Size(screenWidth * 0.365, 69),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(
                          screenWidth * 0.055,
                        ),
                      ),
                    ),
                    child: Text(
                      '아니오',
                      style: TextStyle(
                        fontSize: screenWidth * 0.058,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onDisbandConfirmButtonPressed(
      BuildContext context, WidgetRef ref) async {
    bool succeeded = false;
    try {
      await ref
          .read(recruitRepositoryProvider)
          .deleteParty(partyId.toString());
      succeeded = true;
    } catch (_) {}
    if (context.mounted) {
      Navigator.pushNamed(
        context,
        succeeded ? PageRoutes.disbandSuccess : PageRoutes.disbandFail,
      );
    }
  }
}
