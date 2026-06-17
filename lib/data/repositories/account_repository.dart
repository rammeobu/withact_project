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
        final userId = (data['userId'] ?? data['id']) as int?;
        if (userId != null) await tokenStorage.writeUserId(userId);
        return userId;
      }
      if (data is int) {
        await tokenStorage.writeUserId(data);
        return data;
      }
      final parsed = int.tryParse(data?.toString() ?? '');
      if (parsed != null) await tokenStorage.writeUserId(parsed);
      return parsed;
    } catch (e) {
      throw Exception('로그인 실패');
    }
  }

  Future<void> logout() async {
    client.clearAuthToken();
    await tokenStorage.clear();
  }

  /// 저장된 세션 복원(자동 로그인). 저장된 userId가 있으면 반환하고,
  /// 토큰이 있으면 클라이언트에 다시 적용한다.
  Future<int?> restoreSession() async {
    final token = await tokenStorage.read();
    if (token != null && token.isNotEmpty) client.setAuthToken(token);
    return tokenStorage.readUserId();
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

  Future<void> postEmailRequest(String email) async {}

  Future<void> postEmailAuth(String email, String code) async {}

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
        'skill': profile.profileContent.length > 1 ? profile.profileContent[1] : '',
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

  Future<void> changePassword(
    int userId,
    String currentPassword,
    String newPassword,
  ) async {
    try {
      await client.put('/api/user/v1/$userId/password', {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      });
    } catch (e) {
      if (e.toString().contains('400')) {
        throw Exception('현재 비밀번호가 일치하지 않습니다.');
      }
      throw Exception('비밀번호 변경에 실패했습니다.');
    }
  }
}
