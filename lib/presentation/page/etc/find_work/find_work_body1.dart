import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

class FindWorkBody1 extends StatelessWidget {
  final VoidCallback onWorkSearch;
  final VoidCallback onFilterApplyButtonPressed;
  final String workName;
  final int workCount;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;

  const FindWorkBody1({
    super.key,
    required this.onWorkSearch,
    required this.onFilterApplyButtonPressed,
    required this.workName,
    required this.workCount,
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
              onPressed: onWorkSearch,
              label: Expanded(
                child: TextField(
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
                  onSubmitted: (_) => onWorkSearch(),
                ),
              ),
              icon: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.search, size: screenWidth * 0.073),
                ),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(screenWidth * 0.72, 57),
                foregroundColor: const Color(0xFF636370),
                backgroundColor: posterColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.061),
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.05),
            ElevatedButton(
              onPressed: onFilterApplyButtonPressed,
              style: ElevatedButton.styleFrom(
                fixedSize: Size(screenWidth * 0.15, 46),
                padding: EdgeInsets.zero,
                foregroundColor: const Color(0xFF636370),
                backgroundColor: posterColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.036),
                ),
              ),
              child: Text(
                '필터',
                style: TextStyle(fontSize: screenWidth * 0.036),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Text('$workName에 대한 활동 $workCount팀'),
        ),
      ],
    );
  }
}
