import 'package:flutter/material.dart';

import '../../core/models/screen_contract.dart';
import '../../core/utils/color_utils.dart';
import '../../core/utils/parsing_utils.dart';

Widget buildServerCenter(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final widthFactor = (node.props['widthFactor'] as num?)?.toDouble();
  final heightFactor = (node.props['heightFactor'] as num?)?.toDouble();

  return Center(
    widthFactor: widthFactor,
    heightFactor: heightFactor,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerAlign(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final alignment = parseAlignment(node.props['alignment'] as String?);
  final widthFactor = (node.props['widthFactor'] as num?)?.toDouble();
  final heightFactor = (node.props['heightFactor'] as num?)?.toDouble();

  return Align(
    alignment: alignment,
    widthFactor: widthFactor,
    heightFactor: heightFactor,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerPadding(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final padding = parsePadding(node.props['padding']) ?? const EdgeInsets.all(8);

  return Padding(
    padding: padding,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerSizedBox(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final width = (node.props['width'] as num?)?.toDouble();
  final height = (node.props['height'] as num?)?.toDouble();

  return SizedBox(
    width: width,
    height: height,
    child: node.children.isNotEmpty ? buildSingleChild(node, buildChild) : null,
  );
}

Widget buildServerAspectRatio(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final ratio = (node.props['aspectRatio'] as num?)?.toDouble() ?? 1.0;

  return AspectRatio(
    aspectRatio: ratio,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerFittedBox(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final fit = parseBoxFit(node.props['fit'] as String?);
  final alignment = parseAlignment(node.props['alignment'] as String?);
  final clip = parseClipBehavior(node.props['clipBehavior'] as String?);

  return FittedBox(
    fit: fit,
    alignment: alignment,
    clipBehavior: clip,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerConstrainedBox(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final constraints = parseBoxConstraints(node.props['constraints'] as Map<String, dynamic>?) ??
      const BoxConstraints();

  return ConstrainedBox(
    constraints: constraints,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerFractionallySizedBox(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final widthFactor = (node.props['widthFactor'] as num?)?.toDouble();
  final heightFactor = (node.props['heightFactor'] as num?)?.toDouble();
  final alignment = parseAlignment(node.props['alignment'] as String?);

  return FractionallySizedBox(
    widthFactor: widthFactor,
    heightFactor: heightFactor,
    alignment: alignment,
    child: node.children.isNotEmpty ? buildSingleChild(node, buildChild) : null,
  );
}

Widget buildServerSafeArea(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final top = node.props['top'] as bool? ?? true;
  final bottom = node.props['bottom'] as bool? ?? true;
  final left = node.props['left'] as bool? ?? true;
  final right = node.props['right'] as bool? ?? true;

  return SafeArea(
    top: top,
    bottom: bottom,
    left: left,
    right: right,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerIntrinsicHeight(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  return IntrinsicHeight(child: buildSingleChild(node, buildChild));
}

Widget buildServerIntrinsicWidth(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  return IntrinsicWidth(child: buildSingleChild(node, buildChild));
}

Widget buildServerLimitedBox(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final maxWidth = (node.props['maxWidth'] as num?)?.toDouble() ?? double.infinity;
  final maxHeight = (node.props['maxHeight'] as num?)?.toDouble() ?? double.infinity;

  return LimitedBox(
    maxWidth: maxWidth,
    maxHeight: maxHeight,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerOverflowBox(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final minWidth = (node.props['minWidth'] as num?)?.toDouble();
  final maxWidth = (node.props['maxWidth'] as num?)?.toDouble();
  final minHeight = (node.props['minHeight'] as num?)?.toDouble();
  final maxHeight = (node.props['maxHeight'] as num?)?.toDouble();
  final alignment = parseAlignment(node.props['alignment'] as String?);

  return OverflowBox(
    alignment: alignment,
    minWidth: minWidth,
    maxWidth: maxWidth,
    minHeight: minHeight,
    maxHeight: maxHeight,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerOffstage(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final offstage = node.props['offstage'] as bool? ?? true;

  return Offstage(
    offstage: offstage,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerIgnorePointer(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final ignoring = node.props['ignoring'] as bool? ?? true;

  return IgnorePointer(
    ignoring: ignoring,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerAbsorbPointer(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final absorbing = node.props['absorbing'] as bool? ?? true;

  return AbsorbPointer(
    absorbing: absorbing,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerClipRRect(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final borderRadius = parseBorderRadius(node.props['borderRadius']) ?? BorderRadius.zero;
  final clip = parseClipBehavior(node.props['clipBehavior'] as String?);

  return ClipRRect(
    borderRadius: borderRadius,
    clipBehavior: clip,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerClipOval(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final clip = parseClipBehavior(node.props['clipBehavior'] as String?);

  return ClipOval(
    clipBehavior: clip,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerOpacity(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final opacity = (node.props['opacity'] as num?)?.toDouble() ?? 1.0;

  return Opacity(
    opacity: opacity.clamp(0.0, 1.0),
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerRotatedBox(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final quarterTurns = (node.props['quarterTurns'] as num?)?.toInt() ?? 0;

  return RotatedBox(
    quarterTurns: quarterTurns,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerColoredBox(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final color = parseHexColor(node.props['color'] as String?) ?? Colors.transparent;

  return ColoredBox(
    color: color,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerBaseline(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final baseline = (node.props['baseline'] as num?)?.toDouble() ?? 0;
  final type = (node.props['baselineType'] as String?) == 'ideographic'
      ? TextBaseline.ideographic
      : TextBaseline.alphabetic;

  return Baseline(
    baseline: baseline,
    baselineType: type,
    child: buildSingleChild(node, buildChild),
  );
}
