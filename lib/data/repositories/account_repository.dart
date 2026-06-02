import 'package:party_maker/data/models/profile_data_structures.dart';
import 'package:party_maker/data/network/api_client.dart';

class AccountRepository {
  final ApiClient client;
  AccountRepository(this.client);

  Future<String> postLogin(String id, String password) async {
    try {
      final data = await client.post('/api/auth/login', {
        'loginId': id,
        'password': password,
      });
      return data?.toString() ?? '';
    } catch (e) {
      throw Exception('로그인 실패: $e');
    }
  }

  Future<void> postSignUp(
    String id,
    String password,
    String name,
    String belong,
    String major,
    String skill,
  ) async {
    try {
      await client.post('/api/auth/join', {
        'loginId': id,
        'password': password,
        'passwordConfirm': password,
        'username': name,
        'belong': belong,
        'major': major,
        'skill': skill,
      });
    } catch (e) {
      throw Exception('회원가입 실패: $e');
    }
  }

  Future<void> postEmailRequest(String email) async {
    try {
      await client.post('/api/email/request', {'email': email});
    } catch (e) {
      throw Exception('인증번호 발송 실패: $e');
    }
  }

  Future<void> postEmailVerify(String email, String code) async {
    try {
      await client.post('/api/email/verify', {'email': email, 'code': code});
    } catch (e) {
      throw Exception('이메일 인증 실패: $e');
    }
  }

  Future<void> postLogout() async {
    throw UnimplementedError();
  }

  Future<ProfileAndDetailEditDataStructure> getProfile(String id) async {
    try {
      final data = await client.get('/api/User/v1/$id');
      return ProfileAndDetailEditDataStructure.fromJson(
          data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('프로필 조회 실패: $e');
    }
  }

  Future<void> putProfile(
      String id, ProfileAndDetailEditDataStructure profile) async {
    try {
      await client.put('/api/User/v1/$id/profile', {
        'name': profile.profileContent.length > 0 ? profile.profileContent[0] : '',
        'skill': profile.profileContent.length > 1 ? profile.profileContent[1] : '',
        'belong': profile.profileContent.length > 2 ? profile.profileContent[2] : '',
        'major': profile.profileContent.length > 3 ? profile.profileContent[3] : '',
      });
    } catch (e) {
      throw Exception('프로필 수정 실패: $e');
    }
  }

  Future<void> putDetailInfo(ProfileAndDetailEditDataStructure info) async {
    throw UnimplementedError();
  }

  Future<Map<String, dynamic>> getPersonalInfo() async {
    throw UnimplementedError();
  }

  Future<void> putPersonalInfo(
    String loginId,
    String currentPassword,
    String newPassword,
  ) async {
    throw UnimplementedError();
  }
}
