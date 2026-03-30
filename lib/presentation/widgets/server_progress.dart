import 'package:flutter/material.dart';

import '../../core/models/screen_contract.dart';

Widget buildServerProgress(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final variant = node.props['variant'] as String? ?? 'linear';
  final value = (node.props['value'] as num?)?.toDouble();
  final color = _parseColor(node.props['color'] as String?);
  final trackColor = _parseColor(node.props['trackColor'] as String?);
  final strokeWidth = (node.props['strokeWidth'] as num?)?.toDouble() ?? 4;
  final size = (node.props['size'] as num?)?.toDouble();

  if (variant == 'circular') {
    Widget indicator = CircularProgressIndicator(
      value: value,
      color: color,
      backgroundColor: trackColor,
      strokeWidth: strokeWidth,
    );

    if (size != null) {
      indicator = SizedBox(width: size, height: size, child: indicator);
    }

    return Center(child: indicator);
  }

  return LinearProgressIndicator(
    value: value,
    color: color,
    backgroundColor: trackColor,
    minHeight: strokeWidth,
  );
}

Color? _parseColor(String? hex) {
  if (hex == null || hex.isEmpty) return null;
  final raw = hex.replaceFirst('#', '');
  if (raw.length == 6) return Color(int.parse('FF$raw', radix: 16));
  if (raw.length == 8) return Color(int.parse(raw, radix: 16));
  return null;
}
