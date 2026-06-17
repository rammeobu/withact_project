import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/find_data_structures.dart';

class FindPartyBody1 extends StatelessWidget {
  final VoidCallback onActivitySearch;
  final String activityName;
  final List<PartyItem> partyList;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  const FindPartyBody1({
    super.key,
    required this.onActivitySearch,
    required this.activityName,
    required this.partyList,
    required this.searchController,
    required this.searchFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: onActivitySearch,
              label: TextField(
                controller: searchController,
                focusNode: searchFocusNode,
                style: TextStyle(
                  fontSize: screenWidth * 0.041,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: '활동 검색',
                  hintStyle: TextStyle(
                    color: const Color(0xFF636370),
                    fontSize: screenWidth * 0.041,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onSubmitted: (_) => onActivitySearch(),
              ),
              icon: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.search, size: screenWidth * 0.073),
                ),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(screenWidth * 0.928, 57),
                foregroundColor: const Color(0xFF636370),
                backgroundColor: posterColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.061),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Text(
            activityName.isEmpty
                ? '전체 파티 ${partyList.length}팀'
                : '$activityName에 대한 파티 ${partyList.length}팀',
          ),
        ),
      ],
    );
  }
}
