import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import '../../future&component/layout/default_container.dart';

class ActivityInformationApplyBody1 extends StatelessWidget {
  final String activityOverview;
  final String? poster;
  final ScrollController scrollController;
  const ActivityInformationApplyBody1({
    super.key,
    required this.activityOverview,
    required this.scrollController,
    this.poster,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: DefaultContainer(
            height: 84,
            width: screenWidth * 0.195,
            color: posterColor,
            child: Center(
              child: (poster != null && poster!.startsWith('http'))
                  ? Image.network(
                      poster!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      cacheWidth: 300,
                    )
                  : const Text('포스터'),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.024),
            child: DefaultContainer(
              color: const Color(0xffebedfc),
              width: screenWidth,
              height: 84,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.019),
                child: Scrollbar(
                  controller: scrollController,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        activityOverview,
                        style: TextStyle(
                          fontSize: screenWidth * 0.041,
                          color: appPrimaryColor,
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
