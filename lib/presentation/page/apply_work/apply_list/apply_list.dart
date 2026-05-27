import 'package:flutter/material.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/data/models/apply_data_structures.dart';
import '../../future&component/layout/basic_layout.dart';
import 'apply_party_card/apply_party_card.dart';

class ApplyList extends StatefulWidget {
  final List<ApplyItem> apply;
  ApplyList({super.key, List<ApplyItem>? apply}) : apply = apply ?? [];

  @override
  State<ApplyList> createState() => _ApplyListState();
}

class _ApplyListState extends State<ApplyList> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return BasicLayout(
      title: '파티 지원 목록',
      body: Padding(
        padding: const EdgeInsets.only(top: 13),
        child: widget.apply.isEmpty
            ? Center(
                child: Text(
                  '지원 내역이 없습니다.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: screenWidth * 0.041,
                  ),
                ),
              )
            : Center(
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.apply
                          .map(
                            (apply) => RepaintBoundary(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.024,
                                ),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: screenWidth * 0.85,
                                  ),
                                  child: ApplyPartyCard(
                                    name: apply.name,
                                    timePlace: apply.timePlace ?? [],
                                    applyStatus: apply.applyStatus,
                                    poster: apply.poster,
                                    onDetailButtonPressed: () =>
                                        onDetailButtonPressed(apply.name),
                                    onCheckProfileButtonPressed: () =>
                                        onCheckProfileButtonPressed(apply.name),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
      ),
      bottomNavigationBar: true,
    );
  }

  void onDetailButtonPressed(String name) {
    Navigator.pushNamed(
      context,
      PageRoutes.workInformation,
      arguments: {
        'workName': name,
        'workOverview': '',
        'workDetail': '',
        'leaderProfile': <String>[],
        'position': <String>[],
        'poster': null,
      },
    );
  }

  void onCheckProfileButtonPressed(String name) {
    Navigator.pushNamed(
      context,
      PageRoutes.applyingWork,
      arguments: {'workName': name, 'profile': <String>[], 'poster': null},
    );
  }
}
