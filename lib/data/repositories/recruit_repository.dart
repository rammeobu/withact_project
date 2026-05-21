import 'package:party_maker/data/models/recruit_data_structures.dart';
import 'package:party_maker/data/network/api_client.dart';

class RecruitRepository {
  final ApiClient client;
  RecruitRepository(this.client);

  Future<List<RecruitItem>> getRecruitList() async {
    throw UnimplementedError();
  }

  Future<RecruitAnnouncementDataStructure> getAnnouncement(
    String workId,
  ) async {
    throw UnimplementedError();
  }

  Future<void> postWork(WorkRecruitDataStructure workData) async {
    throw UnimplementedError();
  }

  Future<void> putAnnouncement(
    String workId,
    AnnouncementEditDataStructure announcement,
  ) async {
    throw UnimplementedError();
  }

  Future<void> deleteParty(String partyId) async {
    throw UnimplementedError();
  }
}
