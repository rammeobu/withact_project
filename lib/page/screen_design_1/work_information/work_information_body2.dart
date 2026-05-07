import 'package:flutter/material.dart';

import '../../future&component/layout/person.dart';



class WorkInformationBody2 extends StatefulWidget {
  final List<String> position;
  const WorkInformationBody2({super.key, required this.position});

  @override
  State<WorkInformationBody2> createState() => _WorkInformationBody2State();
}

class _WorkInformationBody2State extends State<WorkInformationBody2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.position.map((e) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Center(child:Text(e, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),)), Person(size: 60.0, onPressed: (){})],
            ),
          )).toList(),
        ),
      ),
    );
  }
}
