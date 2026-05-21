import 'package:party_maker/data/models/applicant_check_data_structure.dart';
import 'package:party_maker/data/models/apply_data_structures.dart';
import 'package:party_maker/data/models/profile_data_structures.dart';
import 'package:party_maker/data/network/api_client.dart';

class ApplyRepository {
  final ApiClient client;
  ApplyRepository(this.client);

  Future<List<ApplyItem>> getApplyList() async {
    throw UnimplementedError();
  }

  Future<ApplyingWorkDataStructure> getApplyingWork(String workId) async {
    throw UnimplementedError();
  }

  Future<ApplicantProfileDataStructure> getApplicantProfile(
    String applicantId,
  ) async {
    throw UnimplementedError();
  }

  Future<List<ApplicantItem>> getApplicants(
    String workId,
    String position,
  ) async {
    throw UnimplementedError();
  }

  Future<void> postApply(String workId, String position) async {
    throw UnimplementedError();
  }

  Future<void> deleteApply(String applyId) async {
    throw UnimplementedError();
  }

  Future<void> deleteParticipation(String participationId) async {
    throw UnimplementedError();
  }
}
