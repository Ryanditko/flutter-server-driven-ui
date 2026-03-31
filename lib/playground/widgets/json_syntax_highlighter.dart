import 'package:flutter/material.dart';

/// Pre-allocated, const [TextStyle] instances to avoid per-span allocation.
abstract final class _JsonStyles {
  static const key = TextStyle(color: Color(0xFF9CDCFE));
  static const string = TextStyle(color: Color(0xFFCE9178));
  static const number = TextStyle(color: Color(0xFFB5CEA8));
  static const keyword = TextStyle(color: Color(0xFF569CD6));
  static const brace = TextStyle(color: Color(0xFFD4D4D4));
  static const normal = TextStyle(color: Color(0xFFD4D4D4));
}

/// Tokenises a JSON string and returns a list of coloured [TextSpan]s.
///
/// Caches the last result so repeated calls with the same input (e.g.
/// during selection changes or cursor moves) return instantly.
class JsonSyntaxHighlighter {
  JsonSyntaxHighlighter._();

  static String _cachedSource = '';
  static List<TextSpan> _cachedSpans = const [];

  static final _tokenPattern = RegExp(
    r'("(?:[^"\\]|\\.)*")\s*:'
    r'|("(?:[^"\\]|\\.)*")'
    r'|(-?\d+(?:\.\d+)?(?:[eE][+-]?\d+)?)'
    r'|\b(true|false)\b'
    r'|\b(null)\b'
    r'|([{}[\],:])',
  );

  static List<TextSpan> highlight(String source) {
    if (source == _cachedSource) return _cachedSpans;

    final spans = <TextSpan>[];
    var lastEnd = 0;

    for (final match in _tokenPattern.allMatches(source)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: source.substring(lastEnd, match.start),
          style: _JsonStyles.normal,
        ));
      }

      final String text = match[0]!;
      final TextStyle style;

      if (match[1] != null) {
        style = _JsonStyles.key;
      } else if (match[2] != null) {
        style = _JsonStyles.string;
      } else if (match[3] != null) {
        style = _JsonStyles.number;
      } else if (match[4] != null || match[5] != null) {
        style = _JsonStyles.keyword;
      } else {
        style = _JsonStyles.brace;
      }

      spans.add(TextSpan(text: text, style: style));
      lastEnd = match.end;
    }

    if (lastEnd < source.length) {
      spans.add(TextSpan(
        text: source.substring(lastEnd),
        style: _JsonStyles.normal,
      ));
    }

    _cachedSource = source;
    _cachedSpans = spans;
    return spans;
  }
}
