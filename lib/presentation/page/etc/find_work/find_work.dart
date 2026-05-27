import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/find_data_structures.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
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
  late List<WorkItem> _workList;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    workSearchController = TextEditingController();
    workSearchFocusNode = FocusNode();
    _workList = widget.workList;
    _fetchWorkList();
  }

  Future<void> _fetchWorkList() async {
    try {
      final result = await ref.read(findRepositoryProvider).getWorkList([]);
      if (mounted) setState(() {
        _workList = result;
        _isLoading = false;
      });
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
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
    final searchedList = _workList
        .where((work) => workName.isEmpty || work.workName.contains(workName))
        .toList();

    return BasicLayout(
      title: '활동 찾기',
      body: ListView.builder(
        controller: scrollController,
        padding: EdgeInsets.only(
          left: screenWidth * 0.036,
          top: 13,
          right: screenWidth * 0.036,
        ),
        itemCount: (_isLoading || searchedList.isEmpty) ? 1 : searchedList.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FindWorkBody1(
                  onWorkSearch: onWorkSearch,
                  onFilterApplyButtonPressed: onFilterButtonPressed,
                  workName: workName,
                  workCount: searchedList.length,
                  searchController: workSearchController,
                  searchFocusNode: workSearchFocusNode,
                ),
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: CircularProgressIndicator(color: appPrimaryColor),
                    ),
                  )
                else if (searchedList.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text(
                        '활동이 없습니다.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenWidth * 0.041,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }
          final work = searchedList[index - 1];
          return RepaintBoundary(
            child: WorkCardFind(
              workName: work.workName,
              timePlace: ['${work.startDate} ~ ${work.endDate}', work.location],
              onWorkInformationButtonPressed: () =>
                  onWorkInformationButtonPressed(work.workName),
              onFindPartyButtonPressed: () =>
                  onFindPartyButtonPressed(work.workName),
            ),
          );
        },
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
