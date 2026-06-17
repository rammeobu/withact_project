import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/find_data_structures.dart';
import 'package:party_maker/presentation/page/etc/activity_map/activity_map_body1.dart';
import 'package:party_maker/presentation/page/etc/activity_map/activity_map_body2.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';
import '../../../../app.dart';

class ActivityMap extends StatefulWidget {
  const ActivityMap({super.key});

  @override
  State<ActivityMap> createState() => ActivityMapState();
}

class ActivityMapState extends State<ActivityMap> {
  late MapController mapController;
  late ScrollController scrollController;
  late ScrollController activityCardController;
  late TextEditingController searchController;
  late FocusNode searchFocusNode;
  String locationName = '서울특별시';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    activityCardController = ScrollController();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
    mapController = MapController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    activityCardController.dispose();
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    const rawActivityList = <List<dynamic>>[];
    final filteredActivityList = searchQuery.isEmpty
        ? rawActivityList
        : rawActivityList
              .where((activity) => (activity[0] as String).contains(searchQuery))
              .toList();

    return BasicLayout(
      title: '활동 지도',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => onRegionActivitySearch(),
                          label: TextField(
                            controller: searchController,
                            focusNode: searchFocusNode,
                            style: TextStyle(
                              fontSize: screenWidth * 0.041,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              hintText: '지역, 활동 검색',
                              hintStyle: TextStyle(
                                color: const Color(0xFF636370),
                                fontSize: screenWidth * 0.041,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                            onSubmitted: (_) => onRegionActivitySearch(),
                          ),
                          icon: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.search,
                                size: screenWidth * 0.073,
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(screenWidth * 0.928, 57),
                            foregroundColor: const Color(0xFF636370),
                            backgroundColor: posterColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.061,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ActivityMapBody1(
                      mapController: mapController,
                      locationName: locationName,
                      selectedName: locationName,
                      onProvinceSelected: onProvinceSelected,
                    ),
                    ActivityMapBody2(
                      activityList: filteredActivityList,
                      activityCardScrollController: activityCardController,
                      onPartyFindButtonPressed: onPartyFindButtonPressed,
                      onDetailButtonPressed: onDetailButtonPressed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: true,
      mapSelected: true,
    );
  }

  void onProvinceSelected(String name) {
    setState(() => locationName = name);
  }

  Future<void> onRegionActivitySearch() async {
    searchFocusNode.unfocus();
    final query = searchController.text.trim();
    if (query.isEmpty) return;

    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?format=json&q=${Uri.encodeComponent(query)}&accept-language=ko&limit=1',
    );
    try {
      final response = await http.get(
        url,
        headers: {'User-Agent': 'com.example.party_maker'},
      );
      if (response.statusCode == 200) {
        final results = jsonDecode(response.body) as List<dynamic>;
        if (results.isNotEmpty) {
          final result = results.first as Map<String, dynamic>;
          final latitude = double.parse(result['lat'] as String);
          final longitude = double.parse(result['lon'] as String);
          if (mounted) {
            mapController.move(
              LatLng(latitude, longitude),
              mapController.camera.zoom,
            );
          }
          if (mounted) setState(() => searchQuery = '');
          return;
        }
      }
      if (mounted) setState(() => searchQuery = query);
    } catch (_) {
      if (mounted) setState(() => searchQuery = query);
    }
  }

  void onDetailButtonPressed(String id) {
    Navigator.pushNamed(
      context,
      PageRoutes.activityInformation,
      arguments: {
        'activityName': id,
        'activityOverview': '',
        'activityDetail': '',
        'leaderProfile': <String>[],
        'position': <String>[],
        'poster': null,
      },
    );
  }

  void onPartyFindButtonPressed(String id) {
    Navigator.pushNamed(
      context,
      PageRoutes.findParty,
      arguments: {'partyList': <PartyItem>[]},
    );
  }
}
