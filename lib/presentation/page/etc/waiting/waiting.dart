import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';

class Waiting extends StatelessWidget {
  const Waiting({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator(color: appPrimaryColor)),
    );
  }
}
