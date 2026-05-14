import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:party_maker/presentation/page/etc/find_party/find_party_body1.dart';
import 'package:party_maker/presentation/page/etc/find_party/party_card.dart';
import 'package:party_maker/presentation/page/etc/work_map/work_map_body1.dart';
import 'package:party_maker/presentation/page/etc/work_map/work_map_body2.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

class FindParty extends StatefulWidget {
  final List<({String partyName, String workName})> partyList;
  const FindParty({super.key, required this.partyList});

  @override
  State<FindParty> createState() => _FindPartyState();
}

class _FindPartyState extends State<FindParty> {
  String workName = '';
  late MapController mapController;
  late ScrollController scrollController;
  late ScrollController workCardController;
  late TextEditingController workSearchController;
  late FocusNode workSearchFocusNode;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    workCardController = ScrollController();
    mapController = MapController();
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
    final double screenHeight = MediaQuery.of(context).size.height;

    return BasicLayout(
      title: '파티 찾기',
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    FindPartyBody1(
                      onWorkSearch: onWorkSearch,
                      onFilterApplyButtonPressed: onFilterButtonPressed,
                      workName: workName,
                      partyList: widget.partyList
                          .where((party) => workName.isEmpty || party.workName.contains(workName))
                          .toList(),
                      searchController: workSearchController,
                      searchFocusNode: workSearchFocusNode,
                    ),
                    Column(
                      children: widget.partyList.where((party) => workName.isEmpty || party.workName.contains(workName))
                      .map<Widget>((party){
                        final String id ='${party.partyName}_${party.workName}';
                        return PartyCard(
                          partyName: party.partyName,
                          workName: party.workName,
                          onPartyLeaderInformationCheckButtonPressed:
                          (){onPartyLeaderInformationCheckButtonPressed(id);},
                          onRecruitAnnouncementCheckButtonPressed:
                          (){onRecruitAnnouncementCheckButtonPressed(id);},
                          onApplyButtonPressed: (){onApplyButtonPressed(id);}
                        );
                      }).toList(),
                    )
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

    setState(() {
      workName = workSearchController.text;
    });
  }
  void onFilterButtonPressed() {}
  void onPartyLeaderInformationCheckButtonPressed(String id){}
  void onRecruitAnnouncementCheckButtonPressed(String id) {}
  void onApplyButtonPressed(String id) {}
}
