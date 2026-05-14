import 'package:flutter/material.dart';
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
    final double screenHeight = MediaQuery.of(context).size.height;

    return BasicLayout(
      title: '활동 정보',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: screenHeight * 0.02),

            // 1단: 원본 위젯에 제목과 포스터를 한 번에 전달
            WorkInformationBody1(
              workOverview: data.workName,
              poster: data.poster, // 포스터 파라미터 활용
              scrollController: _scrollController,
            ),

            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: const Text(
                '요약설명',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
              ),
            ),

            // 2단: 요약 정보 컨테이너
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.012),
              child: DefaultContainer(
                width: double.infinity,
                height: screenHeight * 0.12,
                color: const Color(0xFFF0F2F5),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Text(
                      data.workOverview,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: const Text(
                '상세설명',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
              ),
            ),

            // 3단: 상세 내용 컨테이너
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.012, bottom: 20.0),
              child: DefaultContainer(
                width: double.infinity,
                height: screenHeight * 0.35,
                color: const Color(0xFFF7F8F9),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Scrollbar(
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Text(
                        data.workDetail,
                        style: const TextStyle(fontSize: 15.0, height: 1.6),
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
