import 'package:party_maker/data/models/find_data_structures.dart';
import 'package:party_maker/data/network/api_client.dart';

class FindRepository {
  final ApiClient client;
  FindRepository(this.client);

  Future<List<ActivityItem>> getActivityList(List<FilterItem> filters) async {
    try {
      final data = await client.get('/api/activities/v1');
      return (data as List<dynamic>)
          .map((item) => ActivityItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('활동 목록 불러오기 실패');
    }
  }

  Future<List<PartyItem>> getPartyList(List<FilterItem> filters) async {
    try {
      final data = await client.get('/api/party/v1');
      return (data as List<dynamic>)
          .map((item) => PartyItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('파티 목록 불러오기 실패');
    }
  }

  Future<List<PartyRole>> getPartyRoles(int partyId) async {
    try {
      final data = await client.get('/api/party/v1/$partyId/roles');
      return (data as List<dynamic>)
          .map((item) => PartyRole.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('직군 목록 불러오기 실패');
    }
  }

  Future<Map<String, dynamic>> getActivityDetail(String id) async {
    try {
      final data = await client.get('/api/activities/v1/$id');
      return data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('활동 정보 불러오기 실패');
    }
  }

  Future<List<FilterItem>> getActivityFilters() async {
    return [];
  }

  Future<List<FilterItem>> getPartyFilters() async {
    return [];
  }
}
