import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/find_data_structures.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/presentation/page/etc/find_party/find_party_body1.dart';
import 'package:party_maker/presentation/page/etc/find_party/party_card.dart';
import 'package:party_maker/presentation/page/future&component/component/load_failed_view.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

class FindPartySearchNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }
}

final findPartySearchProvider =
    NotifierProvider.autoDispose<FindPartySearchNotifier, String>(
      FindPartySearchNotifier.new,
    );

class FindParty extends ConsumerStatefulWidget {
  final List<PartyItem> partyList;
  const FindParty({super.key, required this.partyList});

  @override
  ConsumerState<FindParty> createState() => FindPartyState();
}

class FindPartyState extends ConsumerState<FindParty> {
  late ScrollController scrollController;
  late ScrollController activityCardController;
  late TextEditingController activitySearchController;
  late FocusNode activitySearchFocusNode;
  late List<PartyItem> partyList;
  bool isLoading = true;
  bool loadFailed = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    activityCardController = ScrollController();
    activitySearchController = TextEditingController();
    activitySearchFocusNode = FocusNode();
    partyList = widget.partyList;
    fetchPartyList();
  }

  Future<void> fetchPartyList() async {
    try {
      final result = await ref.read(findRepositoryProvider).getPartyList([]);
      if (mounted) setState(() {
        partyList = result;
        isLoading = false;
        loadFailed = false;
      });
    } catch (_) {
      if (mounted) setState(() {
        isLoading = false;
        loadFailed = true;
      });
    }
  }

  void retryFetch() {
    setState(() {
      isLoading = true;
      loadFailed = false;
    });
    fetchPartyList();
  }

  @override
  void dispose() {
    scrollController.dispose();
    activityCardController.dispose();
    activitySearchController.dispose();
    activitySearchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final activityName = ref.watch(findPartySearchProvider);
    final filteredParties = partyList
        .where((party) => activityName.isEmpty || party.partyName.contains(activityName))
        .toList();

    return BasicLayout(
      title: '파티 찾기',
      body: ListView.builder(
        controller: scrollController,
        padding: EdgeInsets.only(
          left: screenWidth * 0.036,
          top: 13,
          right: screenWidth * 0.036,
        ),
        itemCount: (isLoading || filteredParties.isEmpty)
            ? 1
            : filteredParties.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FindPartyBody1(
                  onActivitySearch: onActivitySearch,
                  activityName: activityName,
                  partyList: filteredParties,
                  searchController: activitySearchController,
                  searchFocusNode: activitySearchFocusNode,
                ),
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: CircularProgressIndicator(color: appPrimaryColor),
                    ),
                  )
                else if (loadFailed)
                  LoadFailedView(onRetry: retryFetch)
                else if (filteredParties.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text(
                        '파티가 없습니다.',
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
          final party = filteredParties[index - 1];
          return RepaintBoundary(
            child: PartyCard(
              partyName: party.partyName,
              activityName: party.activityName,
              onPartyLeaderInformationCheckButtonPressed: () =>
                  onPartyLeaderInformationCheckButtonPressed(party),
              onRecruitAnnouncementCheckButtonPressed: () =>
                  onRecruitAnnouncementCheckButtonPressed(party),
              onApplyButtonPressed: () => onApplyButtonPressed(party),
            ),
          );
        },
      ),
      bottomNavigationBar: true,
    );
  }

  void onActivitySearch() {
    activitySearchFocusNode.unfocus();
    Future.delayed(const Duration(milliseconds: 10), () {
      if (mounted) {
        FocusScope.of(context).requestFocus(activitySearchFocusNode);
      }
    });
    ref.read(findPartySearchProvider.notifier).setQuery(
        activitySearchController.text);
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
        'activityName': party.activityName,
        'partyNameIntroduction': party.partyName,
        'position': <String>[],
        'preferences': null,
        'partyId': party.id,
      },
    );
  }

  void onApplyButtonPressed(PartyItem party) {
    Navigator.pushNamed(
      context,
      PageRoutes.applyActivity,
      arguments: {
        'activityName': party.activityName,
        'activityOverview': '',
        'activityDetail': '',
        'leaderProfile': <String>[],
        'position': <String>[],
        'poster': null,
        'partyId': party.id,
        'activityId': party.activityId,
      },
    );
  }
}
