import 'package:flutter/material.dart';

/// Dark-themed text editor styled for JSON editing with monospace font.
class JsonEditorPanel extends StatelessWidget {
  final TextEditingController controller;

  const JsonEditorPanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E1E1E),
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          color: Color(0xFFD4D4D4),
          height: 1.6,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(16),
          border: InputBorder.none,
          hintText: 'Paste or type your JSON contract here...',
          hintStyle: TextStyle(color: Color(0xFF555555)),
        ),
        cursorColor: const Color(0xFF569CD6),
      ),
    );
  }
}
