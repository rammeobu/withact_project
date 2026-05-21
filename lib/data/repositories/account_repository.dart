import 'package:party_maker/data/models/profile_data_structures.dart';
import 'package:party_maker/data/network/api_client.dart';

class AccountRepository {
  final ApiClient client;
  AccountRepository(this.client);

  Future<String> postLogin(String email, String password) async {
    throw UnimplementedError();
  }

  Future<void> postSignUp(String email, String password, String name) async {
    throw UnimplementedError();
  }

  Future<void> postLogout() async {
    throw UnimplementedError();
  }

  Future<ProfileAndDetailEditDataStructure> getProfile() async {
    throw UnimplementedError();
  }

  Future<void> putProfile(ProfileAndDetailEditDataStructure profile) async {
    throw UnimplementedError();
  }

  Future<void> putDetailInfo(ProfileAndDetailEditDataStructure info) async {
    throw UnimplementedError();
  }

  Future<Map<String, dynamic>> getPersonalInfo() async {
    throw UnimplementedError();
  }

  Future<void> putPersonalInfo(
    String email,
    String currentPassword,
    String newPassword,
  ) async {
    throw UnimplementedError();
  }
}
