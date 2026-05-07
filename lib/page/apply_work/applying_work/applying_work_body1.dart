import 'package:flutter/material.dart';
import '../../future&component/layout/default_container.dart';

class ApplyingWorkBody extends StatefulWidget {
  final String section;
  final String content;

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

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.content);
  }

  @override
  void dispose() {
    _controller.dispose();
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
                widget.section,
                style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w800),
              ),
              OutlinedButton(
                onPressed: edit,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  fixedSize: Size(60, 35),
                  side: BorderSide(width: 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10.0),
                  ),
                  backgroundColor: editingMode ? Color(0xff5764f0): Color(0xff1cb879),
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  editingMode ? '저장' : '수정',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: DefaultContainer(
              color: Color(0xffebedf0),
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: editingMode? TextField(
                  controller: _controller,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                    style: TextStyle(fontSize: 17.0),
                )
                    :Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: Text(widget.content, style: TextStyle(fontSize: 17.0)),
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
      if(editingMode){

      }
      editingMode = !editingMode;
    });
  }
}
