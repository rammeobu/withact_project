import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/recruit_data_structures.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/presentation/page/future&component/card_ui.dart';
import '../../future&component/component/load_failed_view.dart';
import '../../future&component/layout/basic_layout.dart';

class RecruitManageSelect extends ConsumerStatefulWidget {
  final List<RecruitItem> recruitList;
  RecruitManageSelect({super.key, List<RecruitItem>? recruitList})
    : recruitList = recruitList ?? [];

  @override
  ConsumerState<RecruitManageSelect> createState() =>
      RecruitManageSelectState();
}

class RecruitManageSelectState extends ConsumerState<RecruitManageSelect> {
  late List<RecruitItem> recruitList;
  bool isLoading = true;
  bool loadFailed = false;

  @override
  void initState() {
    super.initState();
    recruitList = widget.recruitList;
    fetchRecruitList();
  }

  Future<void> fetchRecruitList() async {
    try {
      final result = await ref.read(recruitRepositoryProvider).getRecruitList();
      if (mounted) setState(() {
        recruitList = result;
        isLoading = false;
        loadFailed = false;
      });
    } catch (_) {
      if (mounted) setState(() {
        isLoading = false;
        loadFailed = true;
      });
    }
  }

  void retryFetch() {
    setState(() {
      isLoading = true;
      loadFailed = false;
    });
    fetchRecruitList();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return BasicLayout(
      title: '모집정보 관리',
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: appPrimaryColor),
            )
          : loadFailed
          ? LoadFailedView(onRetry: retryFetch)
          : recruitList.isEmpty
          ? Center(
              child: Text(
                '모집 내역이 없습니다.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenWidth * 0.041,
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(
                top: 13,
                left: screenWidth * 0.036,
                right: screenWidth * 0.036,
              ),
              child: ListView.builder(
                itemCount: recruitList.length,
                itemBuilder: (context, i) {
                  final recruit = recruitList[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Material(
                      color: cardColor,
                      elevation: 2,
                      shadowColor: Colors.black26,
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            PageRoutes.recruitAnnouncement,
                            arguments: {
                              'activityName': recruit.name,
                              'partyNameIntroduction': '',
                              'position': <String>[],
                              'preferences': null,
                              'partyId': recruit.id,
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 18,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  recruit.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.041,
                                    fontWeight: FontWeight.w600,
                                    color: cardInk,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: appPrimaryColor,
                                size: screenWidth * 0.058,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      bottomNavigationBar: true,
    );
  }
}
