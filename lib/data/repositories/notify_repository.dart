import 'package:party_maker/data/models/notify_data_structure.dart';
import 'package:party_maker/data/network/api_client.dart';

class NotifyRepository {
  final ApiClient client;
  NotifyRepository(this.client);

  Future<List<NotificationItem>> getNotificationList() async {
    throw UnimplementedError();
  }
}
