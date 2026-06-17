import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/screen_design_1/activity_information/activity_information_body1.dart';
import '../../future&component/layout/default_container.dart';
import '../../future&component/layout/basic_layout.dart';

class TestActivity {
  final String activityName;
  final String activityOverview;
  final String activityDetail;
  final String? poster;

  TestActivity({
    required this.activityName,
    required this.activityOverview,
    required this.activityDetail,
    this.poster,
  });
}

class ActivityInformationTest extends StatefulWidget {
  final String activityName;
  final String activityOverview;
  final String activityDetail;
  final String? poster;

  const ActivityInformationTest({
    super.key,
    required this.activityName,
    required this.activityOverview,
    required this.activityDetail,
    this.poster,
  });

  @override
  State<ActivityInformationTest> createState() => ActivityInformationTestState();
}

class ActivityInformationTestState extends State<ActivityInformationTest> {
  late ScrollController scrollController;
  late TestActivity data;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    data = TestActivity(
      activityName: widget.activityName,
      activityOverview: widget.activityOverview,
      activityDetail: widget.activityDetail,
      poster: widget.poster,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return BasicLayout(
      title: '활동 정보',
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.049),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(padding: EdgeInsets.only(top: 13)),
            ActivityInformationBody1(
              activityOverview: data.activityName,
              poster: data.poster,
              scrollController: scrollController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Text('요약설명', style: subTitleFont),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: DefaultContainer(
                width: double.infinity,
                height: 101,
                color: const Color(0xFFF0F2F5),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.029),
                  child: SingleChildScrollView(
                    child: Text(
                      data.activityOverview,
                      style: TextStyle(
                        fontSize: screenWidth * 0.034,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Text('상세설명', style: subTitleFont),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 23),
              child: DefaultContainer(
                width: double.infinity,
                height: 295,
                color: const Color(0xFFF7F8F9),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.029),
                  child: Scrollbar(
                    controller: scrollController,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Text(
                        data.activityDetail,
                        style: TextStyle(
                          fontSize: screenWidth * 0.036,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: false,
    );
  }
}
