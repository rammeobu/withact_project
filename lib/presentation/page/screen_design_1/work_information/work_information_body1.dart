import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
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

  double dynamicFontSize(double maxWidth, String text) {
    double fontSize = 16.0;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    while (fontSize > 9.0) {
      textPainter.text = TextSpan(
        text: text,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700),
      );
      textPainter.layout();
      if (textPainter.width <= maxWidth) break;
      fontSize -= 1.0;
    }
    return fontSize;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: DefaultContainer(
            height: screenWidth * 0.195,
            width: screenWidth * 0.195,
            color: posterColor,
            child: Center(
              child: (poster != null && poster!.startsWith('http'))
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(screenWidth * 0.024),
                      child: Image.network(
                        poster!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        cacheWidth: 300,
                      ),
                    )
                  : const Text('포스터'),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.024),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double usableWidth = constraints.maxWidth - 16.0;
                final double fontSize = dynamicFontSize(
                  usableWidth,
                  workOverview,
                );
                return DefaultContainer(
                  color: const Color(0xffebedfc),
                  width: screenWidth,
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.019),
                    child: Scrollbar(
                      controller: scrollController,
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            workOverview,
                            style: TextStyle(
                              fontSize: fontSize,
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
