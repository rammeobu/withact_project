import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/presentation/page/etc/find_party/find_party_body1.dart';
import 'package:party_maker/presentation/page/etc/find_party/party_card.dart';
import 'package:party_maker/data/models/find_data_structures.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

class _FindPartySearchNotifier extends Notifier<String> {
  @override
  String build() => '';
}

final findPartySearchProvider =
    NotifierProvider.autoDispose<_FindPartySearchNotifier, String>(
      _FindPartySearchNotifier.new,
    );

class FindParty extends ConsumerStatefulWidget {
  final List<PartyItem> partyList;
  const FindParty({super.key, required this.partyList});

  @override
  ConsumerState<FindParty> createState() => _FindPartyState();
}

class _FindPartyState extends ConsumerState<FindParty> {
  late ScrollController scrollController;
  late ScrollController workCardController;
  late TextEditingController workSearchController;
  late FocusNode workSearchFocusNode;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    workCardController = ScrollController();
    workSearchController = TextEditingController();
    workSearchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    scrollController.dispose();
    workCardController.dispose();
    workSearchController.dispose();
    workSearchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final workName = ref.watch(findPartySearchProvider);
    final filteredParties = widget.partyList
        .where((party) => workName.isEmpty || party.workName.contains(workName))
        .toList();

    return BasicLayout(
      title: '파티 찾기',
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
                    FindPartyBody1(
                      onWorkSearch: onWorkSearch,
                      workName: workName,
                      partyList: filteredParties,
                      searchController: workSearchController,
                      searchFocusNode: workSearchFocusNode,
                    ),
                    Column(
                      children: filteredParties.map<Widget>((party) {
                        return RepaintBoundary(
                          child: PartyCard(
                            partyName: party.partyName,
                            workName: party.workName,
                            onPartyLeaderInformationCheckButtonPressed: () =>
                                onPartyLeaderInformationCheckButtonPressed(
                                  party,
                                ),
                            onRecruitAnnouncementCheckButtonPressed: () =>
                                onRecruitAnnouncementCheckButtonPressed(party),
                            onApplyButtonPressed: () =>
                                onApplyButtonPressed(party),
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
    ref.read(findPartySearchProvider.notifier).state =
        workSearchController.text;
  }

  void onFilterButtonPressed() {
    Navigator.pushNamed(
      context,
      PageRoutes.findPartyFilter,
      arguments: {
        'filterData': <FilterItem>[],
        'detailCategory': <String, List<String>>{},
      },
    );
  }

  void onPartyLeaderInformationCheckButtonPressed(PartyItem party) {
    Navigator.pushNamed(
      context,
      PageRoutes.partyMemberProfile,
      arguments: {
        'profileContent': List.generate(2, (_) => ''),
        'introduction': '',
        'spec': '',
        'preferences': List.generate(3, (_) => ''),
        'positions': <String>[],
      },
    );
  }

  void onRecruitAnnouncementCheckButtonPressed(PartyItem party) {
    Navigator.pushNamed(
      context,
      PageRoutes.recruitAnnouncement,
      arguments: {
        'workName': party.workName,
        'partyNameIntroduction': party.partyName,
        'position': <String>[],
        'preferences': null,
      },
    );
  }

  void onApplyButtonPressed(PartyItem party) {
    Navigator.pushNamed(
      context,
      PageRoutes.applyWork,
      arguments: {
        'workName': party.workName,
        'workOverview': '',
        'workDetail': '',
        'leaderProfile': <String>[],
        'position': <String>[],
        'poster': null,
      },
    );
  }
}
