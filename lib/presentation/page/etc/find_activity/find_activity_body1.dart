import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';

class FindActivityBody1 extends StatelessWidget {
  final VoidCallback onActivitySearch;
  final VoidCallback onFilterApplyButtonPressed;
  final String activityName;
  final int activityCount;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;

  const FindActivityBody1({
    super.key,
    required this.onActivitySearch,
    required this.onFilterApplyButtonPressed,
    required this.activityName,
    required this.activityCount,
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
                fixedSize: Size(screenWidth * 0.72, 57),
                foregroundColor: const Color(0xFF636370),
                backgroundColor: posterColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.061),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.05),
              child: ElevatedButton(
                onPressed: onFilterApplyButtonPressed,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  fixedSize: Size(screenWidth * 0.15, 46),
                  padding: EdgeInsets.zero,
                  foregroundColor: appPrimaryColor,
                  backgroundColor: cardChipBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.036),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.tune, size: screenWidth * 0.04),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.012),
                      child: Text(
                        '필터',
                        style: TextStyle(
                          fontSize: screenWidth * 0.036,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Text(
            activityName.isEmpty
                ? '전체 활동 $activityCount팀'
                : '$activityName에 대한 활동 $activityCount팀',
          ),
        ),
      ],
    );
  }
}
