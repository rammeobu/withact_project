import 'package:flutter/material.dart';
import '../../future&component/layout/default_container.dart';

class WorkInformationBody1 extends StatelessWidget {
  final String workOverview;
  final String? poster;
  final ScrollController scrollController;
  const WorkInformationBody1({
    super.key,
    required this.workOverview,
    required this.scrollController,
    this.poster,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: DefaultContainer(
            height: screenHeight * 0.1,
            width: 80,
            color: const Color(0xffe3e5e9),
            child: Center(
              child: (poster != null)
                  ? Image.asset(poster!, fit: BoxFit.cover)
                  : const Text('포스터'),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: DefaultContainer(
              color: const Color(0xffebedfc),
              width: MediaQuery.of(context).size.width,
              height: screenHeight * 0.1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Scrollbar(
                  controller: scrollController,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        workOverview,
                        style: const TextStyle(
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
