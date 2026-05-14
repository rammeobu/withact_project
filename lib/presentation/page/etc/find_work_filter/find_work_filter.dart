import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/etc/find_party_filter/find_party_filter_body1.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

import 'find_work_filter_body1.dart';
import 'find_work_filter_footer.dart';

class FindWorkFilter extends StatefulWidget {
  final List<String> filterTitle;
  final List<({String title, List<String> option})> filterData;
  final Map<String, List<String>> detailCategory;

  const FindWorkFilter({
    super.key,
    required this.filterTitle,
    required this.filterData,
    required this.detailCategory,
  });

  @override
  State<FindWorkFilter> createState() => _FindWorkFilterState();
}

class _FindWorkFilterState extends State<FindWorkFilter> {
  late List<String> current;
  late List<List<String>> filter;
  late List<ScrollController> rowScrollControllers;

  @override
  void initState() {
    super.initState();
    filter = widget.filterData.map<List<String>>((record) {
      return <String>['전체', ...record.option];
    }).toList();
    current = List.generate(filter.length, (_) => '전체');
    rowScrollControllers = List.generate(filter.length, (_) => ScrollController());
  }

  @override
  void dispose() {
    for (ScrollController horizontalController in rowScrollControllers) {
      horizontalController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final List<ValueChanged<String>> filterCallback = [
      onWorkCategoryChanged,
      onWorkCategoryDetailChanged,
      onRecruitMemberHeadCountChanged,
      onPreferPositionChanged,
      onPreferPositionCanApplyChanged,
    ];

    return BasicLayout(
      title: '활동 찾기 - 필터',
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.filterData.asMap().entries.map((f) {
                      int i = f.key;
                      return SingleChildScrollView(
                        controller: rowScrollControllers[i],
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: constraints.maxWidth),
                          child: FindWorkFilterBody1(
                            filterTitle: widget.filterTitle[i],
                            filter: filter[i],
                            currentFilter: current[i],
                            onChanged: filterCallback[i],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight*0.015),
            child: FindWorkFilterFooter(
              onApplyFilterButtonPressed: onApplyFilterButtonPressed,
            ),
          ),
        ],
      ),
      bottomNavigationBar: false,
    );
  }

  void onWorkCategoryChanged(String category) {
    setState(() {
      current[0] = category;
      List<String> selectedCategoryDetail = (category == '전체')
          ? <String>[]
          : (widget.detailCategory[category] ?? <String>[]);
      filter[1] = <String>['전체', ...selectedCategoryDetail];
      current[1] = '전체';

      if (rowScrollControllers[1].hasClients) {
        rowScrollControllers[1].jumpTo(0.0);
      }
    });
  }

  void onWorkCategoryDetailChanged(String categoryDetail) => setState(() => current[1] = categoryDetail);
  void onRecruitMemberHeadCountChanged(String headCount) => setState(() => current[2] = headCount);
  void onPreferPositionChanged(String position) => setState(() => current[3] = position);
  void onPreferPositionCanApplyChanged(String canApply) => setState(() => current[4] = canApply);

  void onApplyFilterButtonPressed() {}
}