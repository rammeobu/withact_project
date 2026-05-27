import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/find_data_structures.dart';
import 'package:party_maker/presentation/page/etc/work_map/work_map_body1.dart';
import 'package:party_maker/presentation/page/etc/work_map/work_map_body2.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';
import '../../../../app.dart';

class WorkMap extends StatefulWidget {
  const WorkMap({super.key});

  @override
  State<WorkMap> createState() => _WorkMapState();
}

class _WorkMapState extends State<WorkMap> {
  late MapController mapController;
  late ScrollController scrollController;
  late ScrollController workCardController;
  late TextEditingController searchController;
  late FocusNode searchFocusNode;
  StreamSubscription<MapEvent>? mapEventSubscription;
  Timer? locationFetchTimer;
  String locationName = '서울특별시';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    workCardController = ScrollController();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
    mapController = MapController();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      mapEventSubscription = mapController.mapEventStream.listen(
        onWorkMapMoved,
      );
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    workCardController.dispose();
    searchController.dispose();
    searchFocusNode.dispose();
    mapEventSubscription?.cancel();
    locationFetchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    const rawWorkList = <List<dynamic>>[];
    final filteredWorkList = searchQuery.isEmpty
        ? rawWorkList
        : rawWorkList
              .where((work) => (work[0] as String).contains(searchQuery))
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
                          onPressed: () => onRegionWorkSearch(),
                          label: Expanded(
                            child: TextField(
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
                              onSubmitted: (_) => onRegionWorkSearch(),
                            ),
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
                    WorkMapBody1(
                      mapController: mapController,
                      locationName: locationName,
                    ),
                    WorkMapBody2(
                      workList: filteredWorkList,
                      workCardScrollController: workCardController,
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

  void onWorkMapMoved(MapEvent mapEvent) {
    if (mapEvent is MapEventMoveEnd || mapEvent is MapEventFlingAnimationEnd) {
      locationFetchTimer?.cancel();
      locationFetchTimer = Timer(const Duration(milliseconds: 600), () {
        extractLocationName(mapEvent.camera.center);
      });
    }
  }

  Future<void> extractLocationName(LatLng center) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=${center.latitude}&lon=${center.longitude}&accept-language=ko',
    );
    try {
      final response = await http.get(
        url,
        headers: {'User-Agent': 'com.example.party_maker'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final address = data['address'] as Map<String, dynamic>;

        final city =
            address['city'] as String? ??
            address['town'] as String? ??
            address['village'] as String? ??
            address['state'] as String? ??
            '';
        final district =
            address['county'] as String? ??
            address['city_district'] as String? ??
            '';
        final suburb =
            address['suburb'] as String? ??
            address['quarter'] as String? ??
            address['neighbourhood'] as String? ??
            '';

        final parts = [
          city,
          district,
          suburb,
        ].where((part) => part.isNotEmpty).toList();
        final name = parts.join(' ');
        if (mounted && name.isNotEmpty) setState(() => locationName = name);
      }
    } catch (e) {
      return;
    }
  }

  Future<void> onRegionWorkSearch() async {
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
    } catch (e) {
      if (mounted) setState(() => searchQuery = query);
    }
  }

  void onDetailButtonPressed(String id) {
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

  void onPartyFindButtonPressed(String id) {
    Navigator.pushNamed(
      context,
      PageRoutes.findParty,
      arguments: {'partyList': <PartyItem>[]},
    );
  }
}
