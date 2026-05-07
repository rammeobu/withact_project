import 'package:flutter/material.dart';
import '../../future&component/layout/default_container.dart';



class ApplicantProfileBody1 extends StatelessWidget {
  final String section;
  final String content;
  const ApplicantProfileBody1({
    super.key,
    required this.section,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section,
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: DefaultContainer(
              color: Color(0xffebedf0),
              width: MediaQuery.of(context).size.width,
              height: 75,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: Text(content, style: TextStyle(fontSize: 15.0)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
