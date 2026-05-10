import 'package:flutter/material.dart';
import '../../future&component/layout/default_container.dart';

class WorkRecruitBody2 extends StatefulWidget {
  const WorkRecruitBody2({super.key});

  @override
  State<WorkRecruitBody2> createState() => _WorkRecruitBody2State();
}

class _WorkRecruitBody2State extends State<WorkRecruitBody2> {
  late ScrollController _scrollController;
  List<String> preferences = [];
  final TextEditingController _chipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0.0);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _chipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '우대사항',
                style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.008),
            child: DefaultContainer(
              color: const Color(0xffebedf0),
              width: MediaQuery.of(context).size.width,
              height: screenHeight * 0.08,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...preferences.map(
                        (prefer) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Chip(
                            label: Text('#$prefer'),
                            onDeleted: () {
                              double currentScrollOffset =
                                  _scrollController.offset;
                              setState(() {
                                preferences.remove(prefer);
                              });

                              WidgetsBinding.instance.addPostFrameCallback((
                                _,
                              ) async {
                                await Future.delayed(
                                  const Duration(milliseconds: 50),
                                );

                                if (_scrollController.hasClients) {
                                  _scrollController.jumpTo(currentScrollOffset);
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.easeOut,
                                  );
                                }
                              });
                            },
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),

                      IntrinsicWidth(
                        stepWidth: 100.0,
                        child: TextField(
                          controller: _chipController,
                          onSubmitted: (preference) {
                            final text = preference.trim();
                            if (preference.isNotEmpty) {
                              setState(() {
                                preferences.add(text);
                              });
                              _chipController.clear();

                              Future.delayed(
                                const Duration(milliseconds: 75),
                                () {
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 150),
                                    curve: Curves.easeOut,
                                  );
                                },
                              );
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: '#추가',
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                          ),
                          style: const TextStyle(fontSize: 13.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void search() {}
}
