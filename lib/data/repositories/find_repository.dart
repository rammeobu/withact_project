import 'package:party_maker/data/models/find_data_structures.dart';
import 'package:party_maker/data/network/api_client.dart';

class FindRepository {
  final ApiClient client;
  FindRepository(this.client);

  Future<List<WorkItem>> getWorkList(List<FilterItem> filters) async {
    try {
      final data = await client.get('/api/activities/v1');
      return (data as List<dynamic>)
          .map((item) => WorkItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('활동 목록 불러오기 실패: $e');
    }
  }

  Future<List<PartyItem>> getPartyList(List<FilterItem> filters) async {
    try {
      final data = await client.get('/api/Party/v1');
      return (data as List<dynamic>)
          .map((item) => PartyItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('파티 목록 불러오기 실패: $e');
    }
  }

  Future<Map<String, dynamic>> getWorkDetail(String id) async {
    try {
      final data = await client.get('/api/activities/v1/$id');
      return data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('활동 정보 불러오기 실패: $e');
    }
  }

  Future<List<FilterItem>> getWorkFilters() async {
    return [];
  }

  Future<List<FilterItem>> getPartyFilters() async {
    return [];
  }
}
