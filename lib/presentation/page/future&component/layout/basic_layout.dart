import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_maker/app.dart';

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
    final double screenWidth = MediaQuery.of(context).size.width;
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
                    ? Row(children: needWidget ?? [])
                    : Text(
                        title ?? '',
                        style: GoogleFonts.notoSansKr(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                actions: actions,
              ),
              body: body,
              bottomNavigationBar: bottomNavigationBar
                  ? Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: (mapSelected ?? false)
                                  ? null
                                  : () => Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      PageRoutes.map,
                                      (route) => false,
                                    ),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                disabledForegroundColor: const Color(
                                  0xFFA64B2A,
                                ),
                                fixedSize: Size(screenWidth * 0.292, 57),
                              ),
                              child: Icon(Icons.map, size: screenWidth * 0.097),
                            ),
                            TextButton(
                              onPressed: (homeSelected ?? false)
                                  ? null
                                  : () => Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      PageRoutes.home,
                                      (route) => false,
                                    ),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                disabledForegroundColor: const Color(
                                  0xFFA64B2A,
                                ),
                                fixedSize: Size(screenWidth * 0.292, 57),
                              ),
                              child: Icon(
                                Icons.home,
                                size: screenWidth * 0.097,
                              ),
                            ),
                            TextButton(
                              onPressed: (menuSelected ?? false)
                                  ? null
                                  : () => Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      PageRoutes.menu,
                                      (route) => false,
                                    ),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                disabledForegroundColor: const Color(
                                  0xFFA64B2A,
                                ),
                                fixedSize: Size(screenWidth * 0.292, 57),
                              ),
                              child: Icon(
                                Icons.menu,
                                size: screenWidth * 0.097,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
