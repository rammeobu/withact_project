import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

dynamic parseJson(String body) => jsonDecode(body);

/// 큰 응답은 백그라운드 아이솔레이트에서 디코딩해 메인 스레드 정지(프레임 드랍)를 막는다.
/// 작은 응답은 아이솔레이트 생성 비용이 더 크므로 메인에서 바로 파싱한다.
Future<dynamic> _decode(String body) {
  if (body.length > 20000) return compute(parseJson, body);
  return Future.value(parseJson(body));
}

class ApiClient {
  static const String baseUrl = 'https://backend.withact.xyz';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static const Duration timeout = Duration(seconds: 10);

  Future<dynamic> get(String path) async {
    final response = await http
        .get(Uri.parse('$baseUrl$path'), headers: headers)
        .timeout(timeout, onTimeout: () => throw Exception('GET $path 타임아웃'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return _decode(response.body);
    }
    throw Exception('GET $path 실패: ${response.statusCode}');
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final response = await http
        .post(Uri.parse('$baseUrl$path'), headers: headers, body: jsonEncode(body))
        .timeout(timeout, onTimeout: () => throw Exception('POST $path 타임아웃'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      try {
        return await _decode(response.body);
      } catch (_) {
        return response.body;
      }
    }
    throw Exception('POST $path 실패: ${response.statusCode}');
  }

  Future<dynamic> put(String path, Map<String, dynamic> body) async {
    final response = await http
        .put(Uri.parse('$baseUrl$path'), headers: headers, body: jsonEncode(body))
        .timeout(timeout, onTimeout: () => throw Exception('PUT $path 타임아웃'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return _decode(response.body);
    }
    throw Exception('PUT $path 실패: ${response.statusCode}');
  }

  Future<dynamic> patch(String path, [Map<String, dynamic>? body]) async {
    final response = await http
        .patch(
          Uri.parse('$baseUrl$path'),
          headers: headers,
          body: body == null ? null : jsonEncode(body),
        )
        .timeout(timeout, onTimeout: () => throw Exception('PATCH $path 타임아웃'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return _decode(response.body);
    }
    throw Exception('PATCH $path 실패: ${response.statusCode}');
  }

  Future<void> delete(String path) async {
    final response = await http
        .delete(Uri.parse('$baseUrl$path'), headers: headers)
        .timeout(timeout, onTimeout: () => throw Exception('DELETE $path 타임아웃'));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('DELETE $path 실패: ${response.statusCode}');
    }
  }

  void setAuthToken(String token) {
    headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    headers.remove('Authorization');
  }
}
