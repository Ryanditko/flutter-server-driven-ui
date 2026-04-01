import 'package:flutter/material.dart';

import '../../core/models/screen_contract.dart';
import '../../core/utils/color_utils.dart';
import '../../core/utils/parsing_utils.dart';
import 'server_button.dart';
import 'server_icon.dart' show resolveIcon;

Widget buildServerTextButton(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final label = node.props['label'] as String? ?? '';
  final textColor = parseHexColor(node.props['textColor'] as String?);
  final fontSize = (node.props['fontSize'] as num?)?.toDouble();
  final padding = parsePadding(node.props['padding']);

  return Semantics(
    button: true,
    label: label,
    child: TextButton(
      onPressed: node.action != null ? () => handleAction(context, node.action) : null,
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        padding: padding,
      ),
      child: Text(label, style: TextStyle(fontSize: fontSize)),
    ),
  );
}

Widget buildServerOutlinedButton(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final label = node.props['label'] as String? ?? '';
  final textColor = parseHexColor(node.props['textColor'] as String?);
  final borderColor = parseHexColor(node.props['borderColor'] as String?);
  final borderRadius = (node.props['borderRadius'] as num?)?.toDouble() ?? 8;
  final padding = parsePadding(node.props['padding']);

  return Semantics(
    button: true,
    label: label,
    child: OutlinedButton(
      onPressed: node.action != null ? () => handleAction(context, node.action) : null,
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor,
        side: borderColor != null ? BorderSide(color: borderColor) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        padding: padding,
      ),
      child: Text(label),
    ),
  );
}

Widget buildServerIconButton(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final icon = resolveIcon(node.props['icon'] as String? ?? 'help_outline');
  final size = (node.props['size'] as num?)?.toDouble();
  final color = parseHexColor(node.props['color'] as String?);
  final tooltip = node.props['tooltip'] as String?;
  final padding = parsePadding(node.props['padding']);

  return IconButton(
    icon: Icon(icon, size: size, color: color),
    tooltip: tooltip,
    padding: padding ?? const EdgeInsets.all(8),
    onPressed: node.action != null ? () => handleAction(context, node.action) : null,
  );
}

Widget buildServerFab(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final label = node.props['label'] as String?;
  final icon = resolveIcon(node.props['icon'] as String? ?? 'add');
  final bgColor = parseHexColor(node.props['backgroundColor'] as String?);
  final foregroundColor = parseHexColor(node.props['foregroundColor'] as String?);
  final isExtended = label != null && label.isNotEmpty;
  final mini = node.props['mini'] as bool? ?? false;
  final tooltip = node.props['tooltip'] as String?;

  if (isExtended) {
    return FloatingActionButton.extended(
      onPressed: node.action != null ? () => handleAction(context, node.action) : null,
      icon: Icon(icon),
      label: Text(label),
      backgroundColor: bgColor,
      foregroundColor: foregroundColor,
      tooltip: tooltip,
    );
  }

  return FloatingActionButton(
    onPressed: node.action != null ? () => handleAction(context, node.action) : null,
    mini: mini,
    backgroundColor: bgColor,
    foregroundColor: foregroundColor,
    tooltip: tooltip,
    child: Icon(icon),
  );
}

Widget buildServerSegmentedButton(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final segments = (node.props['segments'] as List<dynamic>?)?.map((s) {
        final seg = s as Map<String, dynamic>;
        return ButtonSegment<String>(
          value: seg['value'] as String? ?? '',
          label: Text(seg['label'] as String? ?? ''),
          icon: seg['icon'] != null ? Icon(resolveIcon(seg['icon'] as String)) : null,
        );
      }).toList() ??
      [];

  final selected = (node.props['selected'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
      {if (segments.isNotEmpty) segments.first.value};

  final multiSelection = node.props['multiSelection'] as bool? ?? false;

  return SegmentedButton<String>(
    segments: segments,
    selected: selected,
    multiSelectionEnabled: multiSelection,
    onSelectionChanged: (_) {},
  );
}
