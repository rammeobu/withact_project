import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/etc/find_party_filter/select_party_filter.dart';

class FindWorkFilterBody1 extends StatelessWidget {
  final String filterTitle;
  final List<String> filter;
  final String currentFilter;
  final ValueChanged<String> onChanged;

  const FindWorkFilterBody1({super.key,
  required this.filterTitle,
  required this.filter,
  required this.currentFilter,
  required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.015,
          ),
          child: Text(
            filterTitle,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SelectPartyFilter(
    filter: filter,
    currentFilter: currentFilter,
    onChanged: onChanged,
    ),
      ],
    );
  }
}
