class NotificationItem {
  final String title;
  final String content;

  const NotificationItem({required this.title, required this.content});

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
    );
  }
}

class NotifyDataStructure {
  final List<NotificationItem> notification;
  final List<String> position;
  final String? profileImage;

  const NotifyDataStructure({
    required this.notification,
    required this.position,
    this.profileImage,
  });
}
