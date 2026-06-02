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
      throw Exception('지원 목록 불러오기 실패: $e');
    }
  }

  Future<ApplyingWorkDataStructure> getApplyingWork(String workId) async {
    throw UnimplementedError();
  }

  Future<ApplicantProfileDataStructure> getApplicantProfile(
      String applicantId) async {
    try {
      final data = await client.get('/api/User/v1/$applicantId');
      return ApplicantProfileDataStructure.fromJson(
          data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('지원자 프로필 불러오기 실패: $e');
    }
  }

  Future<List<ApplicantItem>> getApplicants(String partyId) async {
    try {
      final data = await client.get('/api/application/v1/party/$partyId');
      return (data as List<dynamic>)
          .map((item) => ApplicantItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('지원자 목록 불러오기 실패: $e');
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
      throw Exception('지원 실패: $e');
    }
  }

  Future<void> deleteApply(String id, int userId) async {
    try {
      await client.delete('/api/application/v1/$id?userId=$userId');
    } catch (e) {
      throw Exception('지원 취소 실패: $e');
    }
  }

  Future<void> putApprove(int applicationId) async {
    try {
      await client.put('/api/application/v1/$applicationId/approve', {});
    } catch (e) {
      throw Exception('지원 승인 실패: $e');
    }
  }

  Future<void> putReject(int applicationId) async {
    try {
      await client.put('/api/application/v1/$applicationId/reject', {});
    } catch (e) {
      throw Exception('지원 거절 실패: $e');
    }
  }

  Future<void> deleteParticipation(String participationId) async {
    throw UnimplementedError();
  }
}
