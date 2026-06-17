import 'package:party_maker/data/models/notify_data_structure.dart';
import 'package:party_maker/data/network/api_client.dart';

class NotifyRepository {
  final ApiClient client;
  NotifyRepository(this.client);

  Future<List<NotificationItem>> getNotificationList(int userId) async {
    try {
      final data = await client.get('/api/notify/v1?userId=$userId');
      return (data as List<dynamic>)
          .map(
            (item) => NotificationItem.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('알림 목록 불러오기 실패');
    }
  }
}
