import 'dart:io';
import 'package:flutter/material.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/models/notify_data_structure.dart';

class NotifyBody1 extends StatelessWidget {
  final String? profileImage;
  final VoidCallback onNotificationTap;
  final NotificationItem notification;
  const NotifyBody1({
    super.key,
    required this.notification,
    required this.onNotificationTap,
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Material(
        color: cardColor,
        borderRadius: BorderRadius.circular(screenWidth * 0.122),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onNotificationTap,
          child: SizedBox(
            height: 84,
            width: screenWidth,
            child: Row(
              children: [
                Container(
                  height: 84,
                  width: 84,
                  decoration: BoxDecoration(
                    color: cardColor,
                    border: Border.all(width: 0.1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(screenWidth * 0.122),
                  ),
                  child: (profileImage != null)
                      ? ClipOval(child: Image.file(File(profileImage!)))
                      : const ClipOval(
                          child: Icon(
                            Icons.person,
                            color: Color(0xff9ba2ae),
                            size: 84 - 15,
                          ),
                        ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.012),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: TextStyle(
                          fontSize: screenWidth * 0.044,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        notification.content,
                        style: TextStyle(fontSize: screenWidth * 0.036),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
