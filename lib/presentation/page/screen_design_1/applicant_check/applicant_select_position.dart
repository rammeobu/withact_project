import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/core/constant.dart';
import 'applicant_check.dart';

class ApplicantSelectPosition extends ConsumerWidget {
  final List<String> position;
  const ApplicantSelectPosition({super.key, required this.position});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final currentPosition = ref.watch(applicantPositionProvider);
    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.017),
      child: Row(
        children: position.map((pos) {
          bool isSelected = currentPosition == pos;
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.019,
              vertical: 12,
            ),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                fixedSize: Size(screenWidth * 0.170, 52),
                backgroundColor: isSelected ? appPrimaryColor : Colors.white,
                foregroundColor: isSelected ? Colors.white : Colors.black,
                side: const BorderSide(width: 0.5, color: Colors.grey),
              ),
              onPressed: () {
                ref.read(applicantPositionProvider.notifier).state = pos;
              },
              child: Text(
                pos,
                style: TextStyle(
                  fontSize: screenWidth * 0.049,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
