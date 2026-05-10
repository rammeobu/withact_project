import 'package:flutter/material.dart';
import '../../future&component/layout/default_container.dart';

class ApplyingWorkBody extends StatefulWidget {
  final String? section;
  final String? content;

  const ApplyingWorkBody({
    super.key,
    required this.section,
    required this.content,
  });

  @override
  State<ApplyingWorkBody> createState() => _ApplyingWorkBodyState();
}

class _ApplyingWorkBodyState extends State<ApplyingWorkBody> {
  bool editingMode = false;
  late TextEditingController _controller;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.content);
    _scrollController = ScrollController();

    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.section ?? '',
                style: const TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              OutlinedButton(
                onPressed: edit,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  fixedSize: const Size(60, 35),
                  side: const BorderSide(width: 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10.0),
                  ),
                  backgroundColor: editingMode
                      ? const Color(0xff5764f0)
                      : const Color(0xff1cb879),
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  editingMode ? '저장' : '수정',
                  style: const TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: DefaultContainer(
              color: const Color(0xffebedf0),
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: editingMode
                    ? TextField(
                        controller: _controller,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          hint: Text('내용을 입력해주세요.'),
                          hintStyle: TextStyle(
                            fontSize: 16.0,
                            color: Color(0x4D7F7F7F),
                          ),
                        ),
                        style: const TextStyle(fontSize: 17.0),
                      )
                    : Scrollbar(
                        controller: _scrollController,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Text(
                            widget.content ?? '',
                            style: const TextStyle(fontSize: 17.0),
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void edit() {
    setState(() {
      if (editingMode) {}
      editingMode = !editingMode;
    });
  }
}
