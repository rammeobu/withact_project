class NotificationItem {
  final String title;
  final String content;
  final String? type;
  final int? relatedId;

  const NotificationItem({
    required this.title,
    required this.content,
    this.type,
    this.relatedId,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      type: json['type']?.toString(),
      relatedId: (json['relatedId'] as num?)?.toInt(),
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
