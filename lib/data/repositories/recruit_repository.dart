import 'package:party_maker/data/models/recruit_data_structures.dart';
import 'package:party_maker/data/network/api_client.dart';

class RecruitRepository {
  final ApiClient client;
  RecruitRepository(this.client);

  Future<List<RecruitItem>> getRecruitList() async {
    try {
      final data = await client.get('/api/Party/v1');
      return (data as List<dynamic>)
          .map((item) => RecruitItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('모집 목록 조회 실패: $e');
    }
  }

  Future<RecruitAnnouncementDataStructure> getAnnouncement(String id) async {
    try {
      final data = await client.get('/api/Party/v1/$id');
      return RecruitAnnouncementDataStructure.fromJson(
          data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('모집 공고 조회 실패: $e');
    }
  }

  Future<void> postWork(WorkRecruitDataStructure workData) async {
    try {
      await client.post('/api/Party/v1', {});
    } catch (e) {
      throw Exception('모집 공고 작성 실패: $e');
    }
  }

  Future<void> putAnnouncement(
    String workId,
    AnnouncementEditDataStructure announcement,
  ) async {
    throw UnimplementedError();
  }

  Future<void> deleteParty(String id) async {
    try {
      await client.delete('/api/Party/v1/$id');
    } catch (e) {
      throw Exception('파티 삭제 실패: $e');
    }
  }
}
