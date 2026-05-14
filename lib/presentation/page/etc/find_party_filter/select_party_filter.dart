import 'package:flutter/material.dart';

class SelectPartyFilter extends StatelessWidget {
  final List<String> filter;
  final String currentFilter;
  final ValueChanged<String> onChanged;
  const SelectPartyFilter({
    super.key,
    required this.filter,
    required this.currentFilter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: filter.map((pos) {
        bool isCurrentSelectedPosition = currentFilter == pos;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              fixedSize: const Size(70, 35),
              backgroundColor: (isCurrentSelectedPosition == true)
                  ? const Color(0xFF5764F0)
                  : Colors.white,
              foregroundColor: (isCurrentSelectedPosition == true)
                  ? Colors.white
                  : Colors.black,
              side: const BorderSide(width: 0.5, color: Colors.grey),
            ),
            onPressed: () {
                onChanged(pos);
            },
            child: Text(
              pos,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}