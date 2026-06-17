import 'package:party_maker/data/models/recruit_data_structures.dart';
import 'package:party_maker/data/network/api_client.dart';

class RecruitRepository {
  final ApiClient client;
  RecruitRepository(this.client);

  Future<List<RecruitItem>> getRecruitList() async {
    try {
      final data = await client.get('/api/party/v1');
      final list = (data as List<dynamic>)
          .map((item) => RecruitItem.fromJson(item as Map<String, dynamic>))
          .toList();
      final posters = await _activityPosterMap();
      return list
          .map((r) => (r.poster == null || r.poster!.isEmpty) &&
                  r.activityId != null &&
                  posters[r.activityId] != null
              ? r.copyWith(poster: posters[r.activityId])
              : r)
          .toList();
    } catch (e) {
      throw Exception('모집 목록 조회 실패');
    }
  }

  Future<Map<int, String>> _activityPosterMap() async {
    try {
      final data = await client.get('/api/activities/v1');
      final map = <int, String>{};
      for (final item in (data as List<dynamic>)) {
        final m = item as Map<String, dynamic>;
        final id = (m['id'] as num?)?.toInt();
        final url = m['imageUrl']?.toString();
        if (id != null && url != null && url.isNotEmpty) map[id] = url;
      }
      return map;
    } catch (_) {
      return {};
    }
  }

  Future<List<RecruitItem>> getParticipatingList(int userId) async {
    try {
      final data = await client.get('/api/application/v1/my?userId=$userId');
      return (data as List<dynamic>)
          .where((item) =>
              (item as Map<String, dynamic>)['status'] == 'APPROVED')
          .map((item) {
            final app = item as Map<String, dynamic>;
            return RecruitItem(
              id: (app['partyId'] as num?)?.toInt() ?? 0,
              name: app['partyName']?.toString() ?? '',
            );
          })
          .toList();
    } catch (e) {
      throw Exception('참여 목록 조회 실패');
    }
  }

  Future<RecruitAnnouncementDataStructure> getAnnouncement(String id) async {
    try {
      final data = await client.get('/api/party/v1/$id');
      return RecruitAnnouncementDataStructure.fromJson(
          data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('모집 공고 조회 실패');
    }
  }

  Future<void> postActivity(ActivityRecruitDataStructure activityData) async {
    try {
      final created = await client.post('/api/party/v1', {
        'title': activityData.partyIntroduction,
        'content': activityData.partyIntroduction,
        'activityId': activityData.activityId,
        'leaderId': activityData.leaderId,
      });
      final partyId = created is Map ? created['id'] : null;
      if (partyId != null) {
        for (int i = 0; i < activityData.roleNames.length; i++) {
          await client.post('/api/party/v1/$partyId/roles', {
            'roleName': activityData.roleNames[i],
            'targetCount': i < activityData.roleCounts.length
                ? activityData.roleCounts[i]
                : 1,
            'currentCount': 0,
          });
        }
      }
    } catch (e) {
      throw Exception('모집 공고 작성 실패');
    }
  }

  Future<void> putAnnouncement(int partyId, String content) async {
    try {
      await client.post('/api/party/v1/$partyId', {
        'title': content,
        'content': content,
      });
    } catch (e) {
      throw Exception('공고 수정 실패');
    }
  }

  Future<void> deleteParty(String id) async {
    try {
      await client.delete('/api/party/v1/$id');
    } catch (e) {
      throw Exception('파티 삭제 실패');
    }
  }

  Future<void> leaveParty(int partyId, int userId) async {
    try {
      await client.delete('/api/party/v1/$partyId/member?userId=$userId');
    } catch (e) {
      throw Exception('파티 탈퇴 실패');
    }
  }
}
