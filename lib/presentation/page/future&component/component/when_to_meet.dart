import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'no_scale.dart';

class WhenToMeetTimesNotifier extends Notifier<List<bool>> {
  @override
  List<bool> build() => [];

  void setTimes(List<bool> times) {
    state = times;
  }
}

final whenToMeetAvailableTimesProvider =
    NotifierProvider.autoDispose<WhenToMeetTimesNotifier, List<bool>>(
      WhenToMeetTimesNotifier.new,
    );

class WhenToMeet extends ConsumerStatefulWidget {
  final List<String> days;
  final int begin;
  final int end;
  final List<bool>? initialTimes;
  final bool readOnly;
  final ScrollController scrollController;
  final ScrollController whenToMeetScrollController;
  final TextEditingController timeTextController;
  const WhenToMeet({
    super.key,
    this.days = const ['월', '화', '수', '목', '금', '토', '일'],
    this.begin = 8,
    this.end = 23,
    this.initialTimes,
    this.readOnly = false,
    required this.scrollController,
    required this.whenToMeetScrollController,
    required this.timeTextController,
  });

  static Map<String, List<String>> toSchedule(
    List<bool> times, {
    List<String> days = const ['월', '화', '수', '목', '금', '토', '일'],
    int begin = 8,
  }) {
    final Map<String, List<String>> schedule = {};
    if (days.isEmpty) return schedule;
    final int rowCount = times.length ~/ days.length;
    for (int row = 0; row < rowCount; row++) {
      final int hour = begin + row ~/ 2;
      final String label =
          '${hour.toString().padLeft(2, '0')}:${row % 2 == 1 ? '30' : '00'}';
      for (int d = 0; d < days.length; d++) {
        if (times[row * days.length + d]) {
          schedule.putIfAbsent(days[d], () => <String>[]).add(label);
        }
      }
    }
    return schedule;
  }

  static List<bool> fromSchedule(
    Map<String, List<String>> schedule, {
    List<String> days = const ['월', '화', '수', '목', '금', '토', '일'],
    int begin = 8,
    int end = 23,
  }) {
    final int rowCount = (end - begin) * 2;
    final List<bool> times = List<bool>.filled(rowCount * days.length, false);
    schedule.forEach((day, labels) {
      final int d = days.indexOf(day);
      if (d == -1) return;
      for (final String label in labels) {
        final List<String> parts = label.split(':');
        if (parts.length != 2) continue;
        final int? hour = int.tryParse(parts[0]);
        final int? minute = int.tryParse(parts[1]);
        if (hour == null || minute == null) continue;
        final int row = (hour - begin) * 2 + (minute == 30 ? 1 : 0);
        if (row < 0 || row >= rowCount) continue;
        times[row * days.length + d] = true;
      }
    });
    return times;
  }

  @override
  ConsumerState<WhenToMeet> createState() => WhenToMeetState();
}

class WhenToMeetState extends ConsumerState<WhenToMeet> {
  late int rowCount;
  late List<String> timeOptions;

  @override
  void initState() {
    super.initState();
    rowCount = (widget.end - widget.begin) * 2;
    final List<bool> initialTimes =
        widget.initialTimes ??
        List.generate(rowCount * widget.days.length, (int _) => false);

    timeOptions = [];
    for (int i = widget.begin; i <= widget.end; i++) {
      timeOptions.add('${i.toString().padLeft(2, '0')}:00');
      if (i != widget.end) {
        timeOptions.add('${i.toString().padLeft(2, '0')}:30');
      }
    }

    Future.microtask(() {
      ref.read(whenToMeetAvailableTimesProvider.notifier).setTimes(initialTimes);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final List<bool> availableTimes = ref.watch(
      whenToMeetAvailableTimesProvider,
    );

    return Padding(
      padding: EdgeInsets.only(top: 23, right: screenWidth * 0.024),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Text(
              '요일별 활동 가능 시간/특이사항 입력',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: screenWidth * 0.039,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 17),
            child: NoScale(
              child: !widget.readOnly
                  ? TextField(
                      controller: widget.timeTextController,
                      maxLines: 5,
                      onChanged: (_) => timeParse(),
                      decoration: InputDecoration(
                        hintText:
                            '요일 별 활동 가능한 시간과 특이사항을 작성해주세요.\n\n'
                            '입력 예시)\n'
                            ' - 월 - 09:00 ~ 13:00 / 특이사항: 19시부터 비대면 참여 가능\n'
                            ' - 화요일 - 오전 9시 ~ 오후 4시 30분 / 특이사항: 없음',
                        hintStyle: TextStyle(
                          fontSize: screenWidth * 0.029,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(screenWidth * 0.029),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.019,
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(screenWidth * 0.029),
                      decoration: BoxDecoration(
                        color: const Color(0xffebedf0),
                        borderRadius: BorderRadius.circular(screenWidth * 0.019),
                      ),
                      child: Text(
                        widget.timeTextController.text.isEmpty
                            ? '입력된 활동 가능 시간 정보가 없습니다.'
                            : widget.timeTextController.text,
                        style: TextStyle(
                          fontSize: screenWidth * 0.034,
                          color: Colors.black,
                          height: 1.4,
                        ),
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: 289,
            child: SingleChildScrollView(
              controller: widget.whenToMeetScrollController,
              scrollDirection: Axis.vertical,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Column(
                      children: List.generate(widget.end - widget.begin, (
                        int i,
                      ) {
                        return Container(
                          height: 46,
                          alignment: Alignment.topCenter,
                          child: Text(
                            '${widget.begin + i}시',
                            style: TextStyle(
                              fontSize: screenWidth * 0.029,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }),
                    ),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: availableTimes.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: widget.days.length,
                                  mainAxisExtent: 23,
                                  mainAxisSpacing: 0.0,
                                  crossAxisSpacing: 0.0,
                                ),
                            itemBuilder: (BuildContext context, int i) {
                              return Container(
                                margin: const EdgeInsets.all(0.5),
                                decoration: BoxDecoration(
                                  color: availableTimes[i]
                                      ? Colors.green
                                      : Colors.grey,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 0.5,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void timeParse() {
    final int cellCount = rowCount * widget.days.length;
    List<bool> newAvailableTimes = List.generate(cellCount, (_) => false);
    final RegExp parseTime = RegExp(
      r'([월화수목금토일])(?:요일)?\s*[-:\s]\s*'
      r'(?:(오전|오후)\s*)?(\d{1,2})(?::(\d{2})|시)?(?:\s*(\d{2})분)?\s*~\s*'
      r'(?:(오전|오후)\s*)?(\d{1,2})(?::(\d{2})|시)?(?:\s*(\d{2})분)?',
    );

    final String timeInput = widget.timeTextController.text;
    final List<String> whenToMeetTimes = timeInput.split('\n');

    for (final String time in whenToMeetTimes) {
      if (time.trim().isEmpty) continue;

      final Match? match = parseTime.firstMatch(time);
      if (match != null) {
        final String day = match.group(1)!;

        final int dayIndex = widget.days.indexOf(day);
        if (dayIndex == -1) continue;

        String? beginAmOrPm = match.group(2);
        int startHour = int.parse(match.group(3)!);
        String? beginMinUsingColon = match.group(4);
        String? beginMinUsingKorean = match.group(5);
        int startMin = 0;
        if (beginMinUsingColon != null) {
          startMin = int.parse(beginMinUsingColon);
        }
        if (beginMinUsingKorean != null) {
          startMin = int.parse(beginMinUsingKorean);
        }

        String? endAmOrPm = match.group(6);
        int endHour = int.parse(match.group(7)!);
        String? endMinUsingColon = match.group(8);
        String? endMinUsingKorean = match.group(9);
        int endMin = 0;
        if (endMinUsingColon != null) endMin = int.parse(endMinUsingColon);
        if (endMinUsingKorean != null) endMin = int.parse(endMinUsingKorean);

        if (beginAmOrPm == '오후' && startHour < 12) startHour += 12;
        if (beginAmOrPm == '오전' && startHour == 12) startHour = 0;
        if (endAmOrPm == '오후' && endHour < 12) endHour += 12;
        if (endAmOrPm == '오전' && endHour == 12) endHour = 0;

        if (beginAmOrPm == null &&
            endAmOrPm == '오후' &&
            startHour < 12 &&
            startHour > endHour) {
          if (startHour < widget.begin) startHour += 12;
        }

        int beginIndex =
            (startHour - widget.begin) * 2 + (startMin == 30 ? 1 : 0);
        int endIndex = (endHour - widget.begin) * 2 + (endMin == 30 ? 1 : 0);

        if (beginIndex < 0 || endIndex > rowCount || beginIndex >= endIndex) {
          continue;
        }

        for (int i = beginIndex; i < endIndex; i++) {
          final int availableTimeIndex = (i * widget.days.length) + dayIndex;
          if (availableTimeIndex < newAvailableTimes.length) {
            newAvailableTimes[availableTimeIndex] = true;
          }
        }
      }
    }

    ref.read(whenToMeetAvailableTimesProvider.notifier).setTimes(
        newAvailableTimes);
  }
}
