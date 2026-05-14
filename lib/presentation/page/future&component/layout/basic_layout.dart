import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasicLayout extends StatelessWidget {
  final String? title;
  final Widget body;
  final bool? needTitleExpand;
  final List<Widget>? needWidget;
  final List<Widget>? actions;
  final bool bottomNavigationBar;
  final bool? menuSelected;
  final bool? homeSelected;
  final bool? mapSelected;
  const BasicLayout({
    super.key,
    this.title,
    required this.body,
    required this.bottomNavigationBar,
    this.actions,
    this.needTitleExpand,
    this.needWidget,
    this.menuSelected,
    this.homeSelected,
    this.mapSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Container(
          color: const Color(0xFF6D4C41),
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: const Color(0xFFF6F7F9),
              appBar: AppBar(
                backgroundColor: const Color(0xFF6D4C41),
                foregroundColor: Colors.white,
                elevation: 0,
                title: (needTitleExpand != null && needTitleExpand!)
                    ? Row(children: needWidget!)
                    : Text(
                        title ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                actions: actions,
              ),
              body: body,
              bottomNavigationBar: bottomNavigationBar
                  ? Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: mapButtonOnPressed,
                              style: TextButton.styleFrom(
                                foregroundColor: (mapSelected ?? false)
                                    ? const Color(0xFFA64B2A)
                                    : Colors.black,
                                fixedSize: const Size(120.0, 50.0),
                              ),
                              child: const Icon(Icons.map, size: 40.0),
                            ),
                            TextButton(
                              onPressed: homeButtonOnPressed,
                              style: TextButton.styleFrom(
                                foregroundColor: (homeSelected ?? false)
                                    ? const Color(0xFFA64B2A)
                                    : Colors.black,
                                fixedSize: const Size(120.0, 50.0),
                              ),
                              child: const Icon(Icons.home, size: 40.0),
                            ),
                            TextButton(
                              onPressed: menuButtonOnPressed,
                              style: TextButton.styleFrom(
                                foregroundColor: (menuSelected ?? false)
                                    ? const Color(0xFFA64B2A)
                                    : Colors.black,
                                fixedSize: const Size(120.0, 50.0),
                              ),
                              child: const Icon(Icons.menu, size: 40.0),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
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
