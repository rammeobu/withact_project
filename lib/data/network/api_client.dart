import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

dynamic _parseJson(String body) => jsonDecode(body);

class ApiClient {
  static const String baseUrl = 'https://backend.withact.xyz';

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static const Duration _timeout = Duration(seconds: 10);

  Future<dynamic> get(String path) async {
    final response = await http
        .get(Uri.parse('$baseUrl$path'), headers: headers)
        .timeout(_timeout, onTimeout: () => throw Exception('GET $path 타임아웃'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return await compute(_parseJson, response.body);
    }
    throw Exception('GET $path 실패: ${response.statusCode}');
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final response = await http
        .post(Uri.parse('$baseUrl$path'), headers: headers, body: jsonEncode(body))
        .timeout(_timeout, onTimeout: () => throw Exception('POST $path 타임아웃'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      try {
        return await compute(_parseJson, response.body);
      } catch (_) {
        // 서버가 plain text 반환하는 경우 (ex. 구버전 "로그인 성공") raw string 반환
        return response.body;
      }
    }
    throw Exception('POST $path 실패: ${response.statusCode}');
  }

  Future<dynamic> put(String path, Map<String, dynamic> body) async {
    final response = await http
        .put(Uri.parse('$baseUrl$path'), headers: headers, body: jsonEncode(body))
        .timeout(_timeout, onTimeout: () => throw Exception('PUT $path 타임아웃'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return await compute(_parseJson, response.body);
    }
    throw Exception('PUT $path 실패: ${response.statusCode}');
  }

  Future<void> delete(String path) async {
    final response = await http
        .delete(Uri.parse('$baseUrl$path'), headers: headers)
        .timeout(_timeout, onTimeout: () => throw Exception('DELETE $path 타임아웃'));
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
