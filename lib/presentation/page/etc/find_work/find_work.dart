import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/data/models/find_data_structures.dart';
import 'package:party_maker/presentation/page/etc/find_work/work_card_find.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

import 'find_work_body1.dart';

class _FindWorkSearchNotifier extends Notifier<String> {
  @override
  String build() => '';
}

final findWorkSearchProvider =
    NotifierProvider.autoDispose<_FindWorkSearchNotifier, String>(
      _FindWorkSearchNotifier.new,
    );

class FindWork extends ConsumerStatefulWidget {
  final List<WorkItem> workList;
  const FindWork({super.key, required this.workList});

  @override
  ConsumerState<FindWork> createState() => _FindWorkState();
}

class _FindWorkState extends ConsumerState<FindWork> {
  late ScrollController scrollController;
  late TextEditingController workSearchController;
  late FocusNode workSearchFocusNode;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    workSearchController = TextEditingController();
    workSearchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    scrollController.dispose();
    workSearchController.dispose();
    workSearchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final workName = ref.watch(findWorkSearchProvider);
    final searchedList = widget.workList
        .where((work) => workName.isEmpty || work.workName.contains(workName))
        .toList();

    return BasicLayout(
      title: '활동 찾기',
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.036,
                top: 13,
                right: screenWidth * 0.036,
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    FindWorkBody1(
                      onWorkSearch: onWorkSearch,
                      onFilterApplyButtonPressed: onFilterButtonPressed,
                      workName: workName,
                      workCount: searchedList.length,
                      searchController: workSearchController,
                      searchFocusNode: workSearchFocusNode,
                    ),
                    Column(
                      children: searchedList.map<Widget>((work) {
                        return RepaintBoundary(
                          child: WorkCardFind(
                            workName: work.workName,
                            timePlace: [work.time, work.place],
                            onWorkInformationButtonPressed: () =>
                                onWorkInformationButtonPressed(work.workName),
                            onFindPartyButtonPressed: () =>
                                onFindPartyButtonPressed(work.workName),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: true,
    );
  }

  void onWorkSearch() {
    workSearchFocusNode.unfocus();
    Future.delayed(const Duration(milliseconds: 10), () {
      if (mounted) {
        FocusScope.of(context).requestFocus(workSearchFocusNode);
      }
    });
    ref.read(findWorkSearchProvider.notifier).state = workSearchController.text;
  }

  void onFilterButtonPressed() {
    Navigator.pushNamed(
      context,
      PageRoutes.findWorkFilter,
      arguments: {
        'filterData': <FilterItem>[],
        'detailCategory': <String, List<String>>{},
      },
    );
  }

  void onWorkInformationButtonPressed(String id) {
    Navigator.pushNamed(
      context,
      PageRoutes.workInformation,
      arguments: {
        'workName': id,
        'workOverview': '',
        'workDetail': '',
        'leaderProfile': <String>[],
        'position': <String>[],
        'poster': null,
      },
    );
  }

  void onFindPartyButtonPressed(String id) {
    Navigator.pushNamed(
      context,
      PageRoutes.findParty,
      arguments: {'partyList': <PartyItem>[]},
    );
  }
}
