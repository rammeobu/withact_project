import 'package:party_maker/data/models/applicant_check_data_structure.dart';
import 'package:party_maker/data/models/apply_data_structures.dart';
import 'package:party_maker/data/models/profile_data_structures.dart';
import 'package:party_maker/data/network/api_client.dart';

class ApplyRepository {
  final ApiClient client;
  ApplyRepository(this.client);

  Future<List<ApplyItem>> getApplyList(int userId) async {
    try {
      final data = await client.get('/api/application/v1/my?userId=$userId');
      return (data as List<dynamic>)
          .map((item) => ApplyItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('지원 목록 불러오기 실패');
    }
  }

  Future<ApplyingActivityDataStructure> getApplyingActivity(String activityId) async {
    throw UnimplementedError();
  }

  Future<ApplicantProfileDataStructure> getApplicantProfile(
      String applicantId) async {
    try {
      final data = await client.get('/api/user/v1/$applicantId');
      return ApplicantProfileDataStructure.fromJson(
          data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('지원자 프로필 불러오기 실패');
    }
  }

  Future<List<ApplicantItem>> getApplicants(String partyId) async {
    try {
      final data = await client.get('/api/application/v1/party/$partyId');
      return (data as List<dynamic>)
          .map((item) => ApplicantItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('지원자 목록 불러오기 실패');
    }
  }

  Future<void> postApply(
    int userId,
    int partyId,
    int roleId, {
    String motivation = '',
    String introduction = '',
    String portfolioUrl = '',
  }) async {
    try {
      await client.post('/api/application/v1', {
        'userId': userId,
        'partyId': partyId,
        'roleId': roleId,
        'motivation': motivation,
        'introduction': introduction,
        'portfolioUrl': portfolioUrl,
      });
    } catch (e) {
      throw Exception('지원 실패');
    }
  }

  Future<void> deleteApply(String id, int userId) async {
    try {
      await client.delete('/api/application/v1/$id?userId=$userId');
    } catch (e) {
      throw Exception('지원 취소 실패');
    }
  }

  Future<void> putAccept(int applicationId) async {
    try {
      await client.put('/api/application/v1/$applicationId/approve', {});
    } catch (e) {
      throw Exception('지원 승인 실패');
    }
  }

  Future<void> putDeny(int applicationId) async {
    try {
      await client.put('/api/application/v1/$applicationId/reject', {});
    } catch (e) {
      throw Exception('지원 거절 실패');
    }
  }

  Future<void> submitAvailableTime(
    int userId,
    int activityId,
    Map<String, List<String>> schedule,
  ) async {
    try {
      await client.post('/api/available-time/v1', {
        'userId': userId,
        'activityId': activityId,
        'schedule': schedule,
      });
    } catch (e) {
      throw Exception('활동 가능 시간 저장 실패');
    }
  }

  Future<Map<String, List<String>>> getAvailableTime(
    int userId,
    int activityId,
  ) async {
    try {
      final data = await client
          .get('/api/available-time/v1?userId=$userId&activityId=$activityId');
      final map = data as Map<String, dynamic>;
      return map.map(
        (key, value) => MapEntry(
          key,
          (value as List<dynamic>).map((e) => e.toString()).toList(),
        ),
      );
    } catch (e) {
      throw Exception('활동 가능 시간 조회 실패');
    }
  }

  Future<void> deleteParticipation(String participationId) async {
    throw UnimplementedError();
  }
}
