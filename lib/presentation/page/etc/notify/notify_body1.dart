import 'dart:io';
import 'package:flutter/material.dart';

class NotifyBody1 extends StatefulWidget {
  final String? profileImage;
  final VoidCallback onNotificationTap;
  final ({String title, String content}) notification;
  const NotifyBody1({
    super.key,
    required this.notification,
    required this.onNotificationTap,
    this.profileImage,
  });

  @override
  State<NotifyBody1> createState() => _NotifyBody1State();
}

class _NotifyBody1State extends State<NotifyBody1> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
      child: Material(
        color: const Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(50.0),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.onNotificationTap,
          child: SizedBox(
            height: screenHeight * 0.1,
            width: screenWidth,
            child: Row(
              children: [
                Container(
                  height: screenHeight * 0.1,
                  width: screenHeight * 0.1,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDFDFD),
                    border: Border.all(width: 0.1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: (widget.profileImage != null)
                      ? ClipOval(child: Image.file(File(widget.profileImage!)))
                      : ClipOval(
                          child: Icon(
                            Icons.person,
                            color: const Color(0xff9ba2ae),
                            size: screenHeight * 0.1 - 15,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.notification.title,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.notification.content,
                        style: const TextStyle(fontSize: 15.0),
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
