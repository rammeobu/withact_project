import 'package:flutter/material.dart';

class WhenToMeet extends StatefulWidget {
  final List<String> days;
  final int begin;
  final int end;
  final List<bool>? initialTimes;
  final bool readOnly;
  final ScrollController scrollController;
  const WhenToMeet({
    super.key,
    this.days = const ['월', '화', '수', '목', '금', '토', '일'],
    this.begin = 8,
    this.end = 23,
    this.initialTimes,
    this.readOnly = false,
    required this.scrollController,
  });

  @override
  State<WhenToMeet> createState() => _WhenToMeetState();
}

class _WhenToMeetState extends State<WhenToMeet> {
  late int rowCount;
  late List<bool> selectedTimes;

  @override
  void initState() {
    rowCount = (widget.end - widget.begin) * 2;
    selectedTimes =
        widget.initialTimes ??
        List.generate(rowCount * widget.days.length, (int _) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, right: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(height: 35.0),
                ...List.generate(widget.end - widget.begin, (int index) {
                  return Container(
                    height: 60.0,
                    alignment: Alignment.topCenter,
                    child: Text(
                      '${widget.begin + index}시',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: widget.days
                        .map(
                          (String weekday) => Expanded(
                            child: Center(
                              child: Text(
                                weekday,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 10.0),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: selectedTimes.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.days.length,
                      mainAxisExtent: 30.0,
                      mainAxisSpacing: 0.0,
                      crossAxisSpacing: 0.0,
                    ),
                    itemBuilder: (BuildContext context, int i) {
                      return GestureDetector(
                        onTap: widget.readOnly
                            ? null
                            : () => setState(
                                () => selectedTimes[i] = !selectedTimes[i],
                              ),
                        child: Container(
                          margin: const EdgeInsets.all(0.5),
                          decoration: BoxDecoration(
                            color: selectedTimes[i]
                                ? Colors.green
                                : Colors.grey,
                            border: Border.all(color: Colors.white, width: 0.5),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
