import 'package:flutter/material.dart';

import 'json_syntax_highlighter.dart';

/// [TextEditingController] that returns syntax-highlighted spans from
/// [buildTextSpan], keeping native cursor, selection and scroll behaviour
/// without any overlay hacks or secondary controllers.
class HighlightingController extends TextEditingController {
  HighlightingController({super.text});

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    return TextSpan(
      style: style,
      children: JsonSyntaxHighlighter.highlight(text),
    );
  }
}

/// Dark-themed JSON editor with real-time syntax highlighting and line numbers.
///
/// Expects a [HighlightingController] — the same controller instance the
/// parent uses to read/write the text. No syncing, no copies, zero lag.
class JsonEditorPanel extends StatelessWidget {
  final HighlightingController controller;

  const JsonEditorPanel({super.key, required this.controller});

  static const _monoStyle = TextStyle(
    fontFamily: 'monospace',
    fontSize: 13,
    color: Color(0xFFD4D4D4),
    height: 1.6,
  );

  static const _lineNumStyle = TextStyle(
    fontFamily: 'monospace',
    fontSize: 13,
    color: Color(0xFF858585),
    height: 1.6,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E1E1E),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LineNumberGutter(controller: controller, style: _lineNumStyle),
          Container(width: 1, color: const Color(0xFF333333)),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: _monoStyle,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(16),
                border: InputBorder.none,
                hintText: 'Paste or type your JSON contract here...',
                hintStyle: TextStyle(color: Color(0xFF555555)),
              ),
              cursorColor: const Color(0xFF569CD6),
            ),
          ),
        ],
      ),
    );
  }
}

/// Rebuilds only when the line count actually changes, not on every keystroke.
class _LineNumberGutter extends StatefulWidget {
  final TextEditingController controller;
  final TextStyle style;

  const _LineNumberGutter({required this.controller, required this.style});

  @override
  State<_LineNumberGutter> createState() => _LineNumberGutterState();
}

class _LineNumberGutterState extends State<_LineNumberGutter> {
  int _lineCount = 1;
  String _lineText = '1';

  @override
  void initState() {
    super.initState();
    _updateLineCount();
    widget.controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() {
    final count = '\n'.allMatches(widget.controller.text).length + 1;
    if (count != _lineCount) {
      setState(() {
        _lineCount = count;
        _lineText = List.generate(count, (i) => '${i + 1}').join('\n');
      });
    }
  }

  void _updateLineCount() {
    _lineCount = '\n'.allMatches(widget.controller.text).length + 1;
    _lineText = List.generate(_lineCount, (i) => '${i + 1}').join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      padding: const EdgeInsets.only(top: 16, right: 8),
      alignment: Alignment.topRight,
      child: Text(_lineText, style: widget.style, textAlign: TextAlign.right),
    );
  }
}
