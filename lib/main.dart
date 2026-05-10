import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:party_maker/page/recruit_and_announcement/recruit_announcement/recruit_announcement.dart';
import 'package:party_maker/page/screen_design_1/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> route = {'/': (BuildContext context) => HomeScreen()};
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: RecruitAnnouncement(
        content: ['활동 이름'],
        position: ['PM', 'FE', 'BE'],
      ),
    );
  }
}
