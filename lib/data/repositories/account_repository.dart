import 'package:party_maker/data/models/profile_data_structures.dart';
import 'package:party_maker/data/network/api_client.dart';
import 'package:party_maker/data/network/token_storage.dart';

class AccountRepository {
  final ApiClient client;
  final TokenStorage tokenStorage;
  AccountRepository(this.client, this.tokenStorage);

  Future<int?> postLogin(String id, String password) async {
    try {
      final data = await client.post('/api/auth/login', {
        'loginId': id,
        'password': password,
      });
      if (data is Map<String, dynamic>) {
        final token = data['token'] ?? data['accessToken'] ?? data['access_token'];
        if (token is String && token.isNotEmpty) {
          client.setAuthToken(token);
          await tokenStorage.write(token);
        }
        return (data['userId'] ?? data['id']) as int?;
      }
      if (data is int) {
        return data;
      }
      return int.tryParse(data?.toString() ?? '');
    } catch (e) {
      throw Exception('로그인 실패');
    }
  }

  Future<void> logout() async {
    client.clearAuthToken();
    await tokenStorage.clear();
  }

  Future<void> postSignUp(
    String id,
    String password,
    String name,
    String belong,
    String major,
    String skill, {
    String introduction = '',
    List<String> preference = const [],
  }) async {
    try {
      await client.post('/api/auth/join', {
        'loginId': id,
        'password': password,
        'passwordConfirm': password,
        'username': name,
        'belong': belong,
        'major': major,
        'skill': skill,
        'introduction': introduction,
        'preference': preference,
      });
    } catch (e) {
      throw Exception('회원가입 실패');
    }
  }

  Future<void> postEmailRequest(String email) async {
    try {
      await client.post('/api/email/request', {'email': email});
    } catch (e) {
      throw Exception('인증번호 발송 실패');
    }
  }

  Future<void> postEmailAuth(String email, String code) async {
    try {
      await client.post('/api/email/verify', {'email': email, 'code': code});
    } catch (e) {
      throw Exception('이메일 인증 실패');
    }
  }

  Future<void> postLogout() async {
    try {
      await client.post('/api/auth/logout', {});
    } catch (e) {
      throw Exception('로그아웃 실패');
    }
  }

  Future<ProfileState> getProfile(String id) async {
    try {
      final data = await client.get('/api/user/v1/$id');
      return ProfileState.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('프로필 조회 실패');
    }
  }

  Future<void> putProfile(String id, ProfileState profile) async {
    try {
      await client.put('/api/user/v1/$id/personal', {
        'name': profile.profileContent.isNotEmpty ? profile.profileContent[0] : '',
        'belong': profile.profileContent.length > 2 ? profile.profileContent[2] : '',
        'major': profile.profileContent.length > 3 ? profile.profileContent[3] : '',
        'spec': profile.spec,
        'introduction': profile.introduction,
        'preference': profile.favorites.where((value) => value.isNotEmpty).join(', '),
      });
    } catch (e) {
      throw Exception('프로필 수정 실패');
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
