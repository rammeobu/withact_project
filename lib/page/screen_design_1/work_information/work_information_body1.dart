import 'package:flutter/material.dart';
import '../../future&component/layout/default_container.dart';



class WorkInformationBody1 extends StatelessWidget {
  final String workOverview;
  const WorkInformationBody1({super.key, required this.workOverview});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: DefaultContainer(
            height: 100,
            width: 80,
            color: Color(0xffe3e5e9),
            child: Center(child: Text('포스터')),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: DefaultContainer(
              color: Color(0xffebedfc),
              width: MediaQuery.of(context).size.width,
              height: 100.0,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        workOverview,
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Color(0xff5764f0),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
