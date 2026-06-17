import 'dart:convert';
import 'package:http/http.dart' as http;

dynamic parseJson(String body) => jsonDecode(body);

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
      return parseJson(response.body);
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
        return parseJson(response.body);
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
      return parseJson(response.body);
    }
    throw Exception('PUT $path 실패: ${response.statusCode}');
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
