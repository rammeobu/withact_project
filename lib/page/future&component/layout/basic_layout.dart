import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasicLayout extends StatefulWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  const BasicLayout({
    super.key,
    required this.title,
    required this.body,
    this.actions,
  });

  @override
  State<BasicLayout> createState() => _BasicLayoutState();
}

class _BasicLayoutState extends State<BasicLayout> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Container(
        color: const Color(0xFF3D3D4D),
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: const Color(0xFFF6F7F9),
            appBar: AppBar(
              backgroundColor: const Color(0xFF3D3D4D),
              foregroundColor: Colors.white,
              elevation: 0,
              title: Text(
                widget.title,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              actions: widget.actions,
            ),
            body: widget.body,
            bottomNavigationBar: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: mapButtonOnPressed,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        fixedSize: const Size(120.0, 50.0),
                      ),
                      child: const Icon(Icons.map, size: 40.0),
                    ),
                    TextButton(
                      onPressed: homeButtonOnPressed,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        fixedSize: const Size(120.0, 50.0),
                      ),
                      child: const Icon(Icons.home, size: 40.0),
                    ),
                    TextButton(
                      onPressed: menuButtonOnPressed,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        fixedSize: const Size(120.0, 50.0),
                      ),
                      child: const Icon(Icons.menu, size: 40.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void mapButtonOnPressed() {}
  void homeButtonOnPressed() {}
  void menuButtonOnPressed() {}
}
