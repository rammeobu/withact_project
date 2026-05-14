import 'package:flutter/material.dart';
import '../../future&component/layout/default_container.dart';

class ProfileAndDetailEditBody1 extends StatelessWidget {
  final String section;
  final TextEditingController controller;

  const ProfileAndDetailEditBody1({
    super.key,
    required this.section,
    required this.controller,
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
            style: const TextStyle(fontSize: 21.0, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: DefaultContainer(
              color: const Color(0xffebedf0),
              width: MediaQuery.of(context).size.width,
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    hintText: '$section 내용 입력 혹은 불러오기',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 17.0,
                    ),
                  ),
                  style: const TextStyle(fontSize: 17.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
