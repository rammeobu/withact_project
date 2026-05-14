import 'package:flutter/material.dart';
import 'package:party_maker/presentation/page/etc/notify/notify_body1.dart';
import 'package:party_maker/presentation/page/etc/notify/notify_footer.dart';
import 'package:party_maker/presentation/page/etc/notify/notify_position_select.dart';
import 'package:party_maker/presentation/page/future&component/layout/basic_layout.dart';

class Notify extends StatefulWidget {
  final List<({String title, String content})> notification;
  final List<String> position;
  final String? profileImage;
  const Notify({
    super.key,
    required this.notification,
    required this.position,
    this.profileImage,
  });

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  String initialPosition = '전체';
  late ScrollController scrollController;
  late List<({String title, String content})> notification;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    notification = widget.notification;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BasicLayout(
      title: '알림',
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                      ),
                      child: Text(
                        '새 알림 ${notification.length}건',
                        style: TextStyle(
                          fontSize: 21.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    NotifyPositionSelect(
                      position: widget.position,
                      currentPosition: initialPosition,
                      onChanged: (changedPosition) {
                        setState(() {
                          initialPosition = changedPosition;
                        });
                      },
                    ),
                    SizedBox(height: screenHeight * 0.015),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: notification.map<Widget>((notify) {
                        return InkWell(
                          onTap: onNotificationTap,
                          child: Dismissible(
                            key: Key(
                              '${notify.title}_${notify.content}_${DateTime.now().microsecondsSinceEpoch}}',
                            ),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              setState(() {
                                notification.removeWhere((n) => n == notify);
                              });
                            },
                            child: NotifyBody1(
                              notification: notify,
                              onNotificationTap: onNotificationTap,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
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

  void onNotificationTap() {}
  void onReadAndDeleteButtonPressed() {
    setState(() {
      notification.clear();
    });
  }
}
