import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/core/constant.dart';
import 'find_party_filter.dart';

class SelectPartyFilter extends ConsumerWidget {
  final int filterIndex;
  const SelectPartyFilter({super.key, required this.filterIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final filterState = ref.watch(findPartyFilterProvider);
    if (filterState.filter.isEmpty ||
        filterIndex >= filterState.filter.length) {
      return const SizedBox();
    }
    final filter = filterState.filter[filterIndex];
    final currentFilter = filterState.current[filterIndex];

    return Row(
      children: filter.map((pos) {
        bool isSelected = currentFilter == pos;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.010),
          child: InkWell(
            customBorder: const StadiumBorder(),
            onTap: () {
              HapticFeedback.selectionClick();
              ref
                  .read(findPartyFilterProvider.notifier)
                  .setCurrent(filterIndex, pos);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              constraints: const BoxConstraints(minHeight: 44),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.039),
              decoration: ShapeDecoration(
                color: isSelected ? appPrimaryColor : Colors.white,
                shape: const StadiumBorder(
                  side: BorderSide(width: 0.5, color: Colors.grey),
                ),
              ),
              child: Text(
                pos,
                style: TextStyle(
                  fontSize: screenWidth * 0.036,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
