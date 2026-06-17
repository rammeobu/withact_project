import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/data/providers/repository_providers.dart';

class PartyExitDoubleCheck extends ConsumerStatefulWidget {
  final int partyId;
  const PartyExitDoubleCheck({super.key, this.partyId = 0});

  @override
  ConsumerState<PartyExitDoubleCheck> createState() =>
      PartyExitDoubleCheckState();
}

class PartyExitDoubleCheckState extends ConsumerState<PartyExitDoubleCheck> {
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
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
                      '파티 탈퇴',
                      style: TextStyle(
                        fontSize: screenWidth * 0.085,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 23),
                      child: Text(
                        '정말로 파티를\n 탈퇴하시겠습니까?',
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
                    onPressed:
                        isSubmitting ? null : onPartyExitConfirmButtonPressed,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      minimumSize: Size(screenWidth * 0.365, 69),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(
                          screenWidth * 0.055,
                        ),
                      ),
                    ),
                    child: isSubmitting
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.black,
                            ),
                          )
                        : Text(
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
                    onPressed:
                        isSubmitting ? null : () => Navigator.pop(context),
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

  Future<void> onPartyExitConfirmButtonPressed() async {
    if (isSubmitting) return;
    setState(() => isSubmitting = true);
    HapticFeedback.lightImpact();
    bool succeeded = false;
    final userId = ref.read(currentUserProvider);
    if (userId != null) {
      try {
        await ref
            .read(recruitRepositoryProvider)
            .leaveParty(widget.partyId, userId);
        succeeded = true;
      } catch (_) {}
    }
    if (!mounted) return;
    setState(() => isSubmitting = false);
    Navigator.pushNamed(
      context,
      succeeded ? PageRoutes.partyExitSuccess : PageRoutes.partyExitFail,
    );
  }
}
