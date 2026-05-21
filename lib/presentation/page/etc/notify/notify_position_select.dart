import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/core/constant.dart';
import 'notify.dart';

class NotifyPositionSelect extends ConsumerWidget {
  final List<String> position;
  const NotifyPositionSelect({super.key, required this.position});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final currentPosition = ref.watch(notifyPositionProvider);
    return Row(
      children: position.map((pos) {
        bool isSelected = currentPosition == pos;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.010),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              fixedSize: Size(screenWidth * 0.170, 41),
              backgroundColor: isSelected ? appPrimaryColor : Colors.white,
              foregroundColor: isSelected ? Colors.white : Colors.black,
              side: const BorderSide(width: 0.5, color: Colors.grey),
            ),
            onPressed: () {
              ref.read(notifyPositionProvider.notifier).state = pos;
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
    );
  }
}
