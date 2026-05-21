import 'package:flutter/material.dart';

import '../../component/person.dart';

class WorkCardBody extends StatelessWidget {
  final List<String> position;
  const WorkCardBody({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: position
            .map(
              (positionName) => Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.049),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Person(size: screenWidth * 0.073),
                    Center(
                      child: Text(
                        positionName,
                        style: TextStyle(
                          fontSize: screenWidth * 0.029,
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
