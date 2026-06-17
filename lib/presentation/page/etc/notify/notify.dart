import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/notify_data_structure.dart';
import 'package:party_maker/data/providers/repository_providers.dart';
import 'package:party_maker/presentation/page/etc/notify/notify_body1.dart';
import 'package:party_maker/presentation/page/etc/notify/notify_footer.dart';
import 'package:party_maker/presentation/page/etc/notify/notify_position_select.dart';
import 'package:party_maker/presentation/page/future&component/component/load_failed_view.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

class NotifyPositionNotifier extends Notifier<String> {
  @override
  String build() => '전체';

  void setPosition(String position) {
    state = position;
  }
}

final notifyPositionProvider =
    NotifierProvider.autoDispose<NotifyPositionNotifier, String>(
      NotifyPositionNotifier.new,
    );

class NotifyListNotifier extends Notifier<List<NotificationItem>> {
  @override
  List<NotificationItem> build() => [];

  void init(List<NotificationItem> items) {
    state = List.from(items);
  }

  void dismiss(NotificationItem item) {
    state = state
        .where((notificationItem) => notificationItem != item)
        .toList();
  }

  void clearAll() {
    state = [];
  }
}

final notifyListProvider =
    NotifierProvider.autoDispose<NotifyListNotifier, List<NotificationItem>>(
      NotifyListNotifier.new,
    );

class Notify extends ConsumerStatefulWidget {
  final List<NotificationItem> notification;
  final List<String> position;
  final String? profileImage;
  const Notify({
    super.key,
    required this.notification,
    required this.position,
    this.profileImage,
  });

  @override
  ConsumerState<Notify> createState() => NotifyState();
}

class NotifyState extends ConsumerState<Notify> {
  late ScrollController scrollController;
  bool isLoading = true;
  bool loadFailed = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notifyListProvider.notifier).init(widget.notification);
      fetchNotifications();
    });
  }

  Future<void> fetchNotifications() async {
    final userId = ref.read(currentUserProvider);
    if (userId == null) {
      if (mounted) setState(() => isLoading = false);
      return;
    }
    try {
      final result =
          await ref.read(notifyRepositoryProvider).getNotificationList(userId);
      if (mounted) {
        ref.read(notifyListProvider.notifier).init(result);
        setState(() {
          isLoading = false;
          loadFailed = false;
        });
      }
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
    fetchNotifications();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final notifications = ref.watch(notifyListProvider);
    return BasicLayout(
      title: '알림',
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.036),
              child: RefreshIndicator(
                onRefresh: fetchNotifications,
                color: appPrimaryColor,
                child: SingleChildScrollView(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      child: Text(
                        '새 알림 ${notifications.length}건',
                        style: TextStyle(
                          fontSize: screenWidth * 0.051,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    NotifyPositionSelect(position: widget.position),
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: isLoading
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: appPrimaryColor,
                              ),
                            ),
                          )
                        : loadFailed
                        ? LoadFailedView(onRetry: retryFetch)
                        : notifications.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Center(
                              child: Text(
                                '알림이 없습니다.',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: screenWidth * 0.041,
                                ),
                              ),
                            ),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children:
                                notifications.map<Widget>((notificationItem) {
                              return RepaintBoundary(
                                child: Dismissible(
                                  key: Key(
                                    '${notificationItem.title}_${notificationItem.content}',
                                  ),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (direction) {
                                    ref
                                        .read(notifyListProvider.notifier)
                                        .dismiss(notificationItem);
                                  },
                                  child: NotifyBody1(
                                    notification: notificationItem,
                                    onNotificationTap: () =>
                                        onNotificationTap(notificationItem),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                    ),
                  ],
                ),
              ),
              ),
            ),
          ),
          NotifyFooter(
            onReadAndDeleteButtonPressed: onReadAndDeleteButtonPressed,
          ),
        ],
      ),
      bottomNavigationBar: false,
    );
  }

  void onNotificationTap(NotificationItem item) {
    final relatedId = item.relatedId;
    if (relatedId == null) return;
    if (item.type == 'APPLICATION_RECEIVED') {
      Navigator.pushNamed(
        context,
        PageRoutes.applicantCheck,
        arguments: {'position': widget.position, 'partyId': relatedId},
      );
    } else if (item.type == 'APPLICATION_RESULT') {
      Navigator.pushNamed(
        context,
        PageRoutes.activityInformation,
        arguments: {
          'activityName': '',
          'activityOverview': '',
          'activityDetail': '',
          'leaderProfile': <String>[],
          'position': <String>[],
          'partyId': relatedId,
        },
      );
    }
  }
  void onReadAndDeleteButtonPressed() {
    ref.read(notifyListProvider.notifier).clearAll();
  }
}
