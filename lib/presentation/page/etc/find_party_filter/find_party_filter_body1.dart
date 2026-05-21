import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/etc/find_party_filter/select_party_filter.dart';

class FindPartyFilterBody1 extends StatelessWidget {
  final String filterTitle;
  final int filterIndex;

  const FindPartyFilterBody1({
    super.key,
    required this.filterTitle,
    required this.filterIndex,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Text(
            filterTitle,
            style: TextStyle(
              fontSize: screenWidth * 0.041,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SelectPartyFilter(filterIndex: filterIndex),
      ],
    );
  }
}
