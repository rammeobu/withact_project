import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:party_maker/presentation/page/etc/find_party/find_party.dart';
import 'package:party_maker/presentation/page/etc/find_party_filter/find_party_filter.dart';
import 'package:party_maker/presentation/page/etc/notify/notify.dart';
import 'package:party_maker/presentation/page/etc/participating_party/participating_party.dart';
import 'package:party_maker/presentation/page/etc/work_map/work_map.dart';
import 'package:party_maker/presentation/page/etc/menu/menu.dart';
import 'package:party_maker/presentation/page/screen_design_1/work_information/work_infomation_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FindPartyFilter(
        filterTitle: [
          '활동 종류',
          '활동 종류 - 세부',
          '모집 인원',
          '선호 역할',
          '선호 역할 지원 가능 여부',
        ],
        filterData: [
          (title: '활동 종류', option: ['대외활동', '공모전']),
          (title: '활동 종류 - 세부', option: []),
          (title: '모집 인원', option: ['1명', '2명', '3명']),
          (title: '선호 역할', option: ['개발', '기획', '디자인']),
          (title: '선호 역할 지원 가능 여부', option: ['가능', '불가능']),
        ],
        detailCategory: {
          '대외활동': ['서포터즈', '기자단', '봉사활동'],
          '공모전': ['기획/아이디어', '광고/마케팅', '영상/UCC', 'IT/소프트웨어'],
        },
      ));
  }
}
