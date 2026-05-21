import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/data/models/find_data_structures.dart';
import 'package:party_maker/presentation/page/etc/find_party_filter/find_party_filter_body1.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

import 'find_party_filter_footer.dart';

class FindPartyFilterNotifier
    extends Notifier<({List<String> current, List<List<String>> filter})> {
  Map<String, List<String>> _detailCategory = {};

  @override
  ({List<String> current, List<List<String>> filter}) build() =>
      (current: [], filter: []);

  void init(
    int filterSectionCount,
    List<FilterItem> filterData,
    Map<String, List<String>> detailCategory,
  ) {
    _detailCategory = detailCategory;
    final filter = List.generate(filterSectionCount, (i) {
      if (i < filterData.length) return ['전체', ...filterData[i].option];
      return ['전체'];
    });
    state = (
      current: List.generate(filterSectionCount, (_) => '전체'),
      filter: filter,
    );
  }

  void setCurrent(int i, String value) {
    final newCurrent = List<String>.from(state.current);
    final newFilter = state.filter
        .map((filterOptions) => List<String>.from(filterOptions))
        .toList();
    newCurrent[i] = value;
    if (i == 0) {
      newCurrent[1] = '전체';
      final detailOptions = (value == '전체')
          ? <String>[]
          : (_detailCategory[value] ?? <String>[]);
      newFilter[1] = ['전체', ...detailOptions];
    }
    state = (current: newCurrent, filter: newFilter);
  }
}

final findPartyFilterProvider =
    NotifierProvider.autoDispose<
      FindPartyFilterNotifier,
      ({List<String> current, List<List<String>> filter})
    >(FindPartyFilterNotifier.new);

class FindPartyFilter extends ConsumerStatefulWidget {
  final List<FilterItem> filterData;
  final Map<String, List<String>> detailCategory;

  const FindPartyFilter({
    super.key,
    required this.filterData,
    required this.detailCategory,
  });

  @override
  ConsumerState<FindPartyFilter> createState() => _FindPartyFilterState();
}

class _FindPartyFilterState extends ConsumerState<FindPartyFilter> {
  late List<String> filterTitle;
  late List<ScrollController> rowScrollControllers;

  @override
  void initState() {
    super.initState();
    filterTitle = ['활동 종류', '활동 종류 - 세부', '모집 정원', '선호 역할', '선호 역할 지원 가능 여부'];
    rowScrollControllers = List.generate(
      filterTitle.length,
      (_) => ScrollController(),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(findPartyFilterProvider.notifier)
          .init(filterTitle.length, widget.filterData, widget.detailCategory);
    });
  }

  @override
  void dispose() {
    for (ScrollController controller in rowScrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    ref.listen(findPartyFilterProvider, (prev, next) {
      if (prev != null &&
          prev.current.isNotEmpty &&
          next.current.isNotEmpty &&
          prev.current[0] != next.current[0]) {
        if (rowScrollControllers[1].hasClients) {
          rowScrollControllers[1].jumpTo(0.0);
        }
      }
    });

    return BasicLayout(
      title: '파티 찾기 - 필터',
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.036,
                top: 13,
                right: screenWidth * 0.036,
              ),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: filterTitle.asMap().entries.map((entry) {
                      int i = entry.key;
                      return SingleChildScrollView(
                        controller: rowScrollControllers[i],
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: constraints.maxWidth,
                          ),
                          child: FindPartyFilterBody1(
                            filterTitle: filterTitle[i],
                            filterIndex: i,
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
            padding: const EdgeInsets.only(bottom: 13),
            child: FindPartyFilterFooter(
              onApplyFilterButtonPressed: onApplyFilterButtonPressed,
            ),
          ),
        ],
      ),
      bottomNavigationBar: false,
    );
  }

  void onApplyFilterButtonPressed() {
    Navigator.pop(context, ref.read(findPartyFilterProvider).current);
  }
}
