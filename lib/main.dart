import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/data/network/offline_fallback.dart';
import 'package:party_maker/data/network/token_storage.dart';
import 'package:party_maker/data/providers/repository_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return const Material(
      color: Color(0xFFF6F7F9),
      child: Center(
        child: Text(
          '화면을 불러오지 못했습니다.',
          textDirection: TextDirection.ltr,
          style: TextStyle(color: Color(0xFF636370), fontSize: 16),
        ),
      ),
    );
  };
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final apiClient = OfflineApiClient();
  final tokenStorage = TokenStorage();
  final savedToken = await tokenStorage.read();
  if (savedToken != null && savedToken.isNotEmpty) {
    apiClient.setAuthToken(savedToken);
  }

  runApp(
    ProviderScope(
      overrides: [
        apiClientProvider.overrideWithValue(apiClient),
        tokenStorageProvider.overrideWithValue(tokenStorage),
      ],
      child: const App(),
    ),
  );
}
