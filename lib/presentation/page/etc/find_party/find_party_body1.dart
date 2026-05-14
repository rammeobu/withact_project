import 'package:flutter/material.dart';

class FindPartyBody1 extends StatelessWidget {
  final VoidCallback onWorkSearch;
  final VoidCallback onFilterApplyButtonPressed;
  final String workName;
  final List<dynamic> partyList;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  const FindPartyBody1({super.key, required this.onWorkSearch, required this.onFilterApplyButtonPressed,required this.workName, required this.partyList, required this.searchController, required this.searchFocusNode});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.015),
              child: ElevatedButton.icon(
                onPressed: onWorkSearch,
                label: Expanded(
                  child: TextField(
                    controller: searchController,
                    focusNode: searchFocusNode,
                    style: const TextStyle(fontSize: 17.0, color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: '활동 검색',
                      hintStyle: TextStyle(color: Color(0xFF636370), fontSize: 17.0),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    onSubmitted: (_) => onWorkSearch(),
                  ),
                ),
                icon: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                  ),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.search, size: 30.0),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth * 0.72, 50.0),
                  foregroundColor: const Color(0xFF636370),
                  backgroundColor: const Color(0xffe3e5e9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.05),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.015),
              child: ElevatedButton(
                onPressed: onFilterApplyButtonPressed,
                child: Text('필터', style: TextStyle(fontSize: 15.0)),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth * 0.001, 40.0),
                  padding: EdgeInsets.zero,
                  foregroundColor: const Color(0xFF636370),
                  backgroundColor: const Color(0xffe3e5e9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.015,
          ),
          child: Text('$workName에 대한 파티 ${partyList.length}팀'),
        ),
      ],
    );
  }
}
