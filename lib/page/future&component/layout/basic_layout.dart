import 'package:flutter/material.dart';

class BasicLayout extends StatefulWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  BasicLayout({super.key, required this.title, required this.body, this.actions});

  @override
  State<BasicLayout> createState() => _BasicLayoutState();
}

class _BasicLayoutState extends State<BasicLayout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Color(0xFFF6F7F9),
        appBar: AppBar(
          backgroundColor: Color(0xFF3D3D4D),
          foregroundColor: Colors.white,
          title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.w700)),
          actions: widget.actions,
        ),
        body: widget.body,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            TextButton(
              onPressed: mapButtonOnPressed,
              style: TextButton.styleFrom(foregroundColor: Colors.black, fixedSize: Size(120.0, 50.0)),
              child: Icon(Icons.map, size: 40.0,),
            ),
            TextButton(
              onPressed: homeButtonOnPressed,
              style: TextButton.styleFrom(foregroundColor: Colors.black, fixedSize: Size(120.0, 50.0)),
              child: Icon(Icons.home, size: 40.0),
            ),
            TextButton(
              onPressed: menuButtonOnPressed,
              style: TextButton.styleFrom(foregroundColor: Colors.black, fixedSize: Size(120.0, 50.0)),
              child: Icon(Icons.menu, size: 40.0,),
            ),
          ],
                ),
        ),
    ));
  }

  void mapButtonOnPressed(){}
  void homeButtonOnPressed(){}
  void menuButtonOnPressed(){}
}

class SuccessOrFailLayout extends StatefulWidget {
  String title;
  List<String> buttonContent;
  String imageName;
  String mainText;
  String subText;

  SuccessOrFailLayout({
    super.key,
    required this.title,
    required this.buttonContent,
    required this.imageName,
    required this.mainText,
    required this.subText,
  });

  @override
  State<SuccessOrFailLayout> createState() => _SuccessOrFailLayoutState();
}

class _SuccessOrFailLayoutState extends State<SuccessOrFailLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Image.asset(widget.imageName),
          Text(widget.mainText),
          Text(widget.subText),
        ],
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OutlinedButton(
            onPressed: () {},
            child: Text(widget.buttonContent[0]),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Text(widget.buttonContent[1]),
          ),
        ],
      ),
    );
  }
}

class DoubleCheckLayout extends StatefulWidget {
  String title;
  Widget body;
  String imageName;
  String mainText;
  String subText;
  DoubleCheckLayout({
    super.key,
    required this.title,
    required this.body,
    required this.imageName,
    required this.mainText,
    required this.subText,
  });

  @override
  State<DoubleCheckLayout> createState() => _doubleCheckLayoutState();
}

class _doubleCheckLayoutState extends State<DoubleCheckLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Image.asset(widget.imageName),
          Text(widget.mainText),
          Text(widget.subText),
        ],
      ),
      floatingActionButton: Row(
        children: [
          OutlinedButton(onPressed: () {}, child: Text('예')),
          OutlinedButton(onPressed: () {}, child: Text('아니오')),
        ],
      ),
    );
  }
}
