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
          .map((e) => ApplyItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      throw Exception('지원 목록 불러오기 실패');
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
    } catch (_) {
      throw Exception('지원자 프로필 불러오기 실패');
    }
  }

  Future<List<ApplicantItem>> getApplicants(String partyId) async {
    try {
      final data = await client.get('/api/application/v1/party/$partyId');
      return (data as List<dynamic>)
          .map((e) => ApplicantItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
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
    } catch (_) {
      throw Exception('지원 실패');
    }
  }

  Future<void> deleteApply(String id, int userId) async {
    try {
      await client.delete('/api/application/v1/$id?userId=$userId');
    } catch (_) {
      throw Exception('지원 취소 실패');
    }
  }

  Future<void> deleteParticipation(String participationId) async {
    throw UnimplementedError();
  }
}
