import 'package:flutter/material.dart';

import '../../core/models/screen_contract.dart';
import '../../core/utils/color_utils.dart';
import '../../core/utils/parsing_utils.dart';

Widget buildServerSelectableText(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final content = node.props['content'] as String? ?? '';
  final fontSize = (node.props['fontSize'] as num?)?.toDouble();
  final fontWeight = parseFontWeight(node.props['fontWeight'] as String?);
  final color = parseHexColor(node.props['color'] as String?);
  final textAlign = parseTextAlign(node.props['textAlign'] as String?);
  final maxLines = (node.props['maxLines'] as num?)?.toInt();

  return Semantics(
    label: content,
    child: SelectableText(
      content,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    ),
  );
}

Widget buildServerRichText(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final spans = (node.props['spans'] as List<dynamic>?)?.map((s) {
        final span = s as Map<String, dynamic>;
        return TextSpan(
          text: span['text'] as String? ?? '',
          style: TextStyle(
            fontSize: (span['fontSize'] as num?)?.toDouble(),
            fontWeight: parseFontWeight(span['fontWeight'] as String?),
            fontStyle: parseFontStyle(span['fontStyle'] as String?),
            color: parseHexColor(span['color'] as String?),
            backgroundColor: parseHexColor(span['backgroundColor'] as String?),
            decoration: parseTextDecoration(span['decoration'] as String?),
            letterSpacing: (span['letterSpacing'] as num?)?.toDouble(),
            wordSpacing: (span['wordSpacing'] as num?)?.toDouble(),
            height: (span['height'] as num?)?.toDouble(),
          ),
        );
      }).toList() ??
      [];

  final textAlign = parseTextAlign(node.props['textAlign'] as String?);
  final maxLines = (node.props['maxLines'] as num?)?.toInt();
  final overflow = parseTextOverflow(node.props['overflow'] as String?);

  final semanticLabel = spans.map((s) => s.text ?? '').join();

  return Semantics(
    label: semanticLabel,
    child: RichText(
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: spans,
      ),
    ),
  );
}

Widget buildServerDefaultTextStyle(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final fontSize = (node.props['fontSize'] as num?)?.toDouble();
  final fontWeight = parseFontWeight(node.props['fontWeight'] as String?);
  final color = parseHexColor(node.props['color'] as String?);
  final textAlign = parseTextAlign(node.props['textAlign'] as String?);
  final maxLines = (node.props['maxLines'] as num?)?.toInt();
  final overflow = parseTextOverflow(node.props['overflow'] as String?);

  return DefaultTextStyle(
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow ?? TextOverflow.clip,
    child: buildSingleChild(node, buildChild),
  );
}
