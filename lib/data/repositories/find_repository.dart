import 'package:party_maker/data/models/find_data_structures.dart';
import 'package:party_maker/data/network/api_client.dart';

class FindRepository {
  final ApiClient client;
  FindRepository(this.client);

  // 활동 데이터는 거의 바뀌지 않으므로 세션 동안 1회만 받아 공유한다.
  // (홈 포스터 매핑 · 활동 상세 · 활동 찾기가 같은 캐시를 재사용 → 중복 호출 제거)
  List<ActivityItem>? _activityList;
  final Map<int, Map<String, dynamic>> _activityRaw = {};

  Future<List<ActivityItem>> getActivityList(
    List<FilterItem> filters, {
    bool forceRefresh = false,
  }) async {
    final cached = _activityList;
    if (cached != null && !forceRefresh) return cached;
    if (forceRefresh) {
      _activityList = null;
      _activityRaw.clear();
    }
    try {
      final data = await client.get('/api/activities/v1');
      final raw = (data as List<dynamic>).cast<Map<String, dynamic>>();
      for (final m in raw) {
        final id = (m['id'] as num?)?.toInt();
        if (id != null) _activityRaw[id] = m;
      }
      final list = raw.map((m) => ActivityItem.fromJson(m)).toList();
      _activityList = list;
      return list;
    } catch (e) {
      throw Exception('활동 목록 불러오기 실패');
    }
  }

  /// 활동 id → 포스터(imageUrl) 맵. 캐시가 비어 있으면 목록을 1회 적재한다.
  Future<Map<int, String>> activityPosterMap() async {
    if (_activityList == null) {
      try {
        await getActivityList(const []);
      } catch (_) {}
    }
    final map = <int, String>{};
    _activityRaw.forEach((id, m) {
      final url = m['imageUrl']?.toString();
      if (url != null && url.isNotEmpty) map[id] = url;
    });
    return map;
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
    final intId = int.tryParse(id);
    if (intId != null && _activityRaw.containsKey(intId)) {
      return _activityRaw[intId]!;
    }
    try {
      final data = await client.get('/api/activities/v1/$id');
      final map = data as Map<String, dynamic>;
      if (intId != null) _activityRaw[intId] = map;
      return map;
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
