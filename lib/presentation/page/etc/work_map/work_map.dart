import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:party_maker/presentation/page/etc/work_map/work_map_body1.dart';
import 'package:party_maker/presentation/page/etc/work_map/work_map_body2.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

class WorkMap extends StatefulWidget {
  const WorkMap({super.key});

  @override
  State<WorkMap> createState() => _WorkMapState();
}

class _WorkMapState extends State<WorkMap> {
  late MapController mapController;
  late ScrollController scrollController;
  late ScrollController workCardController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    workCardController = ScrollController();
    mapController = MapController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    workCardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return BasicLayout(
      title: '활동 지도',
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.015),
                          child: ElevatedButton.icon(
                            onPressed: onRegionWorkSearch,
                            label: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '지역/활동 검색',
                                style: TextStyle(fontSize: 17.0),
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
                            onPressed: onFilterButtonPressed,
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
                    WorkMapBody1(mapController: mapController),
                    WorkMapBody2(
                      workList: [
                        [
                          '이름',
                          ['시간', '장소'],
                        ],
                        [
                          '이름',
                          ['시간', '장소'],
                        ],
                        [
                          '이름',
                          ['시간', '장소'],
                        ],
                        [
                          '이름',
                          ['시간', '장소'],
                        ],
                      ],
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

  void onRegionWorkSearch() {}
  void onFilterButtonPressed() {}
  void onDetailButtonPressed(String id) {}
  void onPartyFindButtonPressed(String id) {}
}
