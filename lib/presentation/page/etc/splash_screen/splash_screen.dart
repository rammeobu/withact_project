import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:party_maker/app.dart';
import 'package:party_maker/core/constant.dart';
import 'package:party_maker/data/providers/repository_providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  final String? logo;
  const SplashScreen({super.key, this.logo});

  @override
  ConsumerState<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => bootstrap());
  }

  Future<void> bootstrap() async {
    int? userId;
    try {
      userId = await ref.read(accountRepositoryProvider).restoreSession();
    } catch (_) {}
    // 최소 스플래시 노출
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    if (userId != null) {
      // 자동 로그인
      ref.read(currentUserProvider.notifier).setUserId(userId);
      ref.read(loggedInProvider.notifier).setLoggedIn(true);
      Navigator.pushNamedAndRemoveUntil(
        context,
        PageRoutes.home,
        (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        PageRoutes.login,
        (route) => false,
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/images/app_logo.png'), context);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/app_logo.png',
              width: screenWidth * 0.219,
              height: screenWidth * 0.219,
              fit: BoxFit.contain,
              cacheWidth: 400,
            ),
            Padding(
              padding: EdgeInsets.only(top: screenWidth * 0.073),
              child: const CircularProgressIndicator(color: appPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
