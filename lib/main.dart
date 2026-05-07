import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:party_maker/page/apply_work/applying_work/applying_work.dart';
import 'package:party_maker/page/screen_design_1/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> route = {'/': (BuildContext context) => HomeScreen()};
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: ApplyingWork(profile: ['소개','스펙'], workName: '활동 이름')
    );
  }
}
