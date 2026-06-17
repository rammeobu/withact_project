import 'package:party_maker/data/network/api_client.dart';

const Object offlineMiss = Object();

const bool offlineFullBackend = false;

const Map<String, dynamic> offlineProfileReal = {'name': 'test', 'spec': '3'};

class OfflineApiClient extends ApiClient {
  @override
  Future<dynamic> get(String path) async {
    try {
      return await super.get(path);
    } catch (e) {
      final data = offlineData('GET', path);
      if (!identical(data, offlineMiss)) return data;
      rethrow;
    }
  }

  @override
  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    try {
      return await super.post(path, body);
    } catch (e) {
      final data = offlineData('POST', path);
      if (!identical(data, offlineMiss)) return data;
      rethrow;
    }
  }

  @override
  Future<dynamic> put(String path, Map<String, dynamic> body) async {
    try {
      return await super.put(path, body);
    } catch (e) {
      return <String, dynamic>{};
    }
  }

  @override
  Future<void> delete(String path) async {
    try {
      await super.delete(path);
    } catch (e) {
      return;
    }
  }
}

Object? offlineData(String method, String path) {
  final p = path.split('?').first;
  if (method == 'GET') {
    if (p == '/api/activities/v1') return offlineActivities;
    if (RegExp(r'^/api/activities/v1/\d+$').hasMatch(p)) return offlineActivityDetail;
    if (p == '/api/party/v1' || p == '/api/party/v1/joined') {
      if (offlineFullBackend) return offlineParties;
      return offlineParties.map((e) => {...e, 'activityTitle': ''}).toList();
    }
    if (RegExp(r'^/api/party/v1/\d+/roles$').hasMatch(p)) {
      return offlineFullBackend ? offlineRoles : const <Map<String, dynamic>>[];
    }
    if (RegExp(r'^/api/party/v1/\d+$').hasMatch(p)) {
      if (offlineFullBackend) return offlinePartyDetail;
      return {...offlinePartyDetail, 'roles': const <Map<String, dynamic>>[]};
    }
    if (p == '/api/application/v1/my') {
      return offlineFullBackend ? offlineApplications : const <Map<String, dynamic>>[];
    }
    if (RegExp(r'^/api/application/v1/party/\d+$').hasMatch(p)) {
      return offlineFullBackend ? offlineApplicants : const <Map<String, dynamic>>[];
    }
    if (RegExp(r'^/api/user/v1/\d+$').hasMatch(p)) {
      return offlineFullBackend ? offlineProfile : offlineProfileReal;
    }
    if (p == '/api/notify/v1') {
      return offlineFullBackend ? offlineNotifications : const <Map<String, dynamic>>[];
    }
  }
  if (method == 'POST') {
    if (p == '/api/auth/login') return const {'userId': 1, 'token': 'offline-session'};
    if (p == '/api/party/v1') return const {'id': 9001};
    if (p == '/api/auth/join') return const <String, dynamic>{};
    if (p == '/api/application/v1') return const <String, dynamic>{};
    if (p == '/api/available-time/v1') return const <String, dynamic>{};
    if (RegExp(r'^/api/party/v1/\d+/roles$').hasMatch(p)) return const <String, dynamic>{};
    if (RegExp(r'^/api/party/v1/\d+$').hasMatch(p)) return const <String, dynamic>{};
  }
  return offlineMiss;
}

const List<Map<String, dynamic>> offlineActivities = [
  {
    'id': 1,
    'title': '2026년 제4회 AI프로그래밍(무인이동체제어) 민간기능경기대회',
    'startDate': '',
    'endDate': '',
    'location': '온라인',
    'organization': '사단법인 한국기능연합회',
    'category': '공모전',
  },
  {
    'id': 2,
    'title': '[국립인천해양박물관] 바다의 날 기념 제 1회 바다네컷 그리기 대회',
    'startDate': '',
    'endDate': '',
    'location': '온라인',
    'organization': '협동조합 꿈꾸는 문화놀이터 뜻',
    'category': '공모전',
  },
  {
    'id': 5,
    'title': '2026 우주항공·제조 산업 현장 AI 적용 아이디어 공모전',
    'startDate': '',
    'endDate': '',
    'location': '온라인',
    'organization': '중소벤처기업부',
    'category': '공모전',
  },
  {
    'id': 7,
    'title': '2026 관광데이터 활용 공모전(생성형 AI 활용 관광 프롬프톤 부문)',
    'startDate': '',
    'endDate': '',
    'location': '온라인',
    'organization': '한국관광공사',
    'category': '공모전',
  },
];

const Map<String, dynamic> offlineActivityDetail = {
  'id': 1,
  'title': '2026년 제4회 AI프로그래밍(무인이동체제어) 민간기능경기대회',
  'startDate': '',
  'endDate': '',
  'location': '온라인',
  'organization': '사단법인 한국기능연합회',
  'category': '공모전',
  'description':
      '2026년 제4회 AI프로그래밍(무인이동체제어) 민간기능경기대회\n[공모주제]\n드론 코딩\n[공모내용]\n무인이동체를 활용한 프로그래밍 기술력 및 창의적 문제 해결 능력 향상\n[지원자격]\n드론 코딩에 관심 있는 누구나\n[모집기간]\n~ 2026.06.19 23:30\n[지원방법]\n네이버폼 참가 신청서 제출 후 드론 코딩 영상을 촬영하여 이메일 제출',
};

const List<Map<String, dynamic>> offlineParties = [
  {'id': 2, 'title': '공모전 팀원 구합니다', 'activityId': 1, 'leaderId': 1, 'activityTitle': '2026년 제4회 AI프로그래밍(무인이동체제어) 민간기능경기대회'},
  {'id': 3, 'title': '대외활동 같이해요', 'activityId': 2, 'leaderId': 1, 'activityTitle': '[국립인천해양박물관] 바다의 날 기념 제 1회 바다네컷 그리기 대회'},
  {'id': 10, 'title': 'IT 공모전 팀원 모집', 'activityId': 1, 'leaderId': 1, 'activityTitle': '2026년 제4회 AI프로그래밍(무인이동체제어) 민간기능경기대회'},
];

const Map<String, dynamic> offlinePartyDetail = {
  'id': 2,
  'title': '공모전 팀원 구합니다',
  'activityId': 1,
  'activityTitle': '2026년 제4회 AI프로그래밍(무인이동체제어) 민간기능경기대회',
  'content': '디자이너 1명 구해요. AI프로그래밍 경진대회 함께 준비할 팀원을 찾습니다.',
  'leaderName': '',
  'leaderSkill': '',
  'roles': [
    {'id': 1, 'roleName': '기획', 'targetCount': 2, 'currentCount': 1},
    {'id': 2, 'roleName': '디자인', 'targetCount': 1, 'currentCount': 0},
  ],
};

const List<Map<String, dynamic>> offlineRoles = [
  {'id': 1, 'roleName': '기획', 'targetCount': 2, 'currentCount': 1},
  {'id': 2, 'roleName': '디자인', 'targetCount': 2, 'currentCount': 0},
  {'id': 3, 'roleName': '프론트엔드', 'targetCount': 1, 'currentCount': 0},
];

const List<Map<String, dynamic>> offlineApplications = [
  {'id': 201, 'partyName': '광고 공모전 같이 나가요', 'status': 'PENDING'},
  {'id': 202, 'partyName': '해커톤 팀원 모집', 'status': 'APPROVED'},
];

const List<Map<String, dynamic>> offlineApplicants = [
  {'id': 301, 'userName': '이지원', 'roleName': '기획', 'skill': '기획 / PM'},
  {'id': 302, 'userName': '박디자', 'roleName': '디자인', 'skill': 'UI/UX'},
];

const Map<String, dynamic> offlineProfile = {
  'name': '홍길동',
  'skill': 'Flutter / Dart',
  'spec': 'Flutter / Dart',
  'belong': 'OO대학교',
  'major': '컴퓨터공학과',
  'introduction': '안녕하세요, 함께 성장할 팀원을 찾고 있습니다.',
  'preference': ['협업', '공모전', '개발'],
};

const List<Map<String, dynamic>> offlineNotifications = [
  {'title': '지원 결과 안내', 'content': '해커톤 팀원 모집에 합격하셨습니다.'},
  {'title': '새 지원자', 'content': '광고 공모전 파티에 새 지원자가 있습니다.'},
];
