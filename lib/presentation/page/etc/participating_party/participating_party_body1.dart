import 'package:flutter/material.dart';
import '../../future&component/layout/default_container.dart';

class ParticipatingPartyBody1 extends StatelessWidget {
  final String workOverview;
  final String? poster;
  final ScrollController scrollController;
  const ParticipatingPartyBody1({
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
    final double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: DefaultContainer(
            height: 80,
            width: 80,
            color: const Color(0xffe3e5e9),
            child: Center(
              child: (poster != null && poster!.startsWith('http'))
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        poster!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    )
                  : (poster != null)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        poster!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    )
                  : const Text('포스터'),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double usableWidth = constraints.maxHeight - 16.0;
                final double fontSize = dynamicFontSize(
                  usableWidth,
                  workOverview,
                );

                return DefaultContainer(
                  color: const Color(0xffebedfc),
                  width: MediaQuery.of(context).size.width,
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
                              fontSize: 16.0,
                              color: Color(0xff5764f0),
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
