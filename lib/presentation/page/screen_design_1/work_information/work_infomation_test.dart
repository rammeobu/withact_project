import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/presentation/page/screen_design_1/work_information/work_information_body1.dart';
import '../../future&component/layout/default_container.dart';
import '../../future&component/layout/basic_layout.dart';

class TestWork {
  final String workName;
  final String workOverview;
  final String workDetail;
  final String? poster;

  TestWork({
    required this.workName,
    required this.workOverview,
    required this.workDetail,
    this.poster,
  });
}

class WorkInformationTest extends StatefulWidget {
  final String workName;
  final String workOverview;
  final String workDetail;
  final String? poster;

  const WorkInformationTest({
    super.key,
    required this.workName,
    required this.workOverview,
    required this.workDetail,
    this.poster,
  });

  @override
  State<WorkInformationTest> createState() => _WorkInformationTestState();
}

class _WorkInformationTestState extends State<WorkInformationTest> {
  late ScrollController _scrollController;
  late TestWork data;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    data = TestWork(
      workName: widget.workName,
      workOverview: widget.workOverview,
      workDetail: widget.workDetail,
      poster: widget.poster,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
            WorkInformationBody1(
              workOverview: data.workName,
              poster: data.poster,
              scrollController: _scrollController,
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
                      data.workOverview,
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
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Text(
                        data.workDetail,
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
