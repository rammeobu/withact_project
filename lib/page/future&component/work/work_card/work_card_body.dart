import 'package:flutter/material.dart';

import '../../layout/person.dart';


class WorkCardBody extends StatefulWidget {
  final List<String> position;
  const WorkCardBody({super.key, required this.position});

  @override
  State<WorkCardBody> createState() => _WorkCardBodyState();
}

class _WorkCardBodyState extends State<WorkCardBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: widget.position
              .map(
                (e) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Person(size: 35.0),
                      Center(
                        child: Text(
                          e,
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
    );
  }
}
