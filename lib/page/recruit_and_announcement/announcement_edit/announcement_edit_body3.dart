import 'package:flutter/material.dart';

import '../../future&component/component/person.dart';

class AnnouncementEditBody3 extends StatefulWidget {
  final ScrollController primaryScrollController;
  const AnnouncementEditBody3({
    super.key,
    required this.primaryScrollController,
  });

  @override
  State<AnnouncementEditBody3> createState() => _AnnouncementEditBody3State();
}

class _AnnouncementEditBody3State extends State<AnnouncementEditBody3> {
  List<String> position = [];
  List<TextEditingController> controllers = [TextEditingController(text: '')];
  final ScrollController horizontalScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (TextEditingController controller in controllers) {
      controller.dispose();
    }
    horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '모집역할/인원',
              style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w800),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  position.add('');
                  controllers.add(TextEditingController(text: ''));
                });

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (widget.primaryScrollController.hasClients) {
                    widget.primaryScrollController.animateTo(
                      widget.primaryScrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 50),
                      curve: Curves.easeOut,
                    );
                  }
                  if (horizontalScrollController.hasClients) {
                    horizontalScrollController.animateTo(
                      horizontalScrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 50),
                      curve: Curves.easeOut,
                    );
                  }
                });
              },
              icon: const Icon(Icons.add_circle_outline, size: 30.0),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.011),
          child: SingleChildScrollView(
            controller: horizontalScrollController,
            scrollDirection: Axis.horizontal,
            child: position.isEmpty
                ? Center(
                    child: SizedBox(
                      height: 130,
                      width: MediaQuery.of(context).size.width - 30,
                      child: const Center(
                        child: Text(
                          '모집 역할을 추가해주세요.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  )
                : Row(
                    children: position.asMap().entries.map((entry) {
                      final int i = entry.key;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: controllers[i],
                                  textAlign: TextAlign.center,
                                  onChanged: (pos) {
                                    position[i] = pos;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: '직군',
                                    hintStyle: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 4.0,
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Person(size: 50.0),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(width: 0.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    20.0,
                                  ),
                                ),
                                backgroundColor: const Color(0xFFF34343),
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                double currentVerticalScrollOffset =
                                    widget.primaryScrollController.offset;
                                double currentHorizontalScrollOffset =
                                    horizontalScrollController.offset;

                                setState(() {
                                  controllers[i].dispose();
                                  controllers.removeAt(i);
                                  position.removeAt(i);
                                });

                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) async {
                                  await Future.delayed(
                                    const Duration(milliseconds: 10),
                                  );

                                  if (widget
                                      .primaryScrollController
                                      .hasClients) {
                                    if (position.isEmpty) {
                                      widget.primaryScrollController.animateTo(
                                        widget
                                            .primaryScrollController
                                            .position
                                            .maxScrollExtent,
                                        duration: const Duration(
                                          milliseconds: 400,
                                        ),
                                        curve: Curves.easeOut,
                                      );
                                    }
                                  }

                                  if (horizontalScrollController.hasClients) {
                                    horizontalScrollController.jumpTo(
                                      currentHorizontalScrollOffset,
                                    );
                                    horizontalScrollController.animateTo(
                                      horizontalScrollController
                                          .position
                                          .maxScrollExtent,
                                      duration: const Duration(
                                        milliseconds: 50,
                                      ),
                                      curve: Curves.easeOut,
                                    );
                                  }
                                });
                              },
                              child: const Text(
                                '제거',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ),
      ],
    );
  }
}
