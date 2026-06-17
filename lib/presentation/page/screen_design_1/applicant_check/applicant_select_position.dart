import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        children: ['전체', ...position].map((pos) {
          bool isSelected = currentPosition == pos;
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.019,
              vertical: 12,
            ),
            child: InkWell(
              customBorder: const StadiumBorder(),
              onTap: () {
                HapticFeedback.selectionClick();
                ref.read(applicantPositionProvider.notifier).setPosition(pos);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                width: screenWidth * 0.170,
                height: 52,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  color: isSelected ? appPrimaryColor : Colors.white,
                  shape: const StadiumBorder(
                    side: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                child: Text(
                  pos,
                  style: TextStyle(
                    fontSize: screenWidth * 0.049,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
