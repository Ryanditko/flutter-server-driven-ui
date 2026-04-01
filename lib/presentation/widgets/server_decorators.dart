import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/models/screen_contract.dart';
import '../../core/utils/color_utils.dart';
import '../../core/utils/parsing_utils.dart';

Widget buildServerMaterial(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final elevation = (node.props['elevation'] as num?)?.toDouble() ?? 0;
  final color = parseHexColor(node.props['color'] as String?);
  final borderRadius = parseBorderRadius(node.props['borderRadius']);
  final type = (node.props['materialType'] as String?) == 'transparency'
      ? MaterialType.transparency
      : MaterialType.canvas;

  return Material(
    elevation: elevation,
    color: color,
    borderRadius: borderRadius,
    type: type,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerHero(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final tag = node.props['tag'] as String? ?? node.id ?? 'hero';

  return Hero(
    tag: tag,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerIndexedStack(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final index = (node.props['index'] as num?)?.toInt() ?? 0;
  final alignment = parseAlignment(node.props['alignment'] as String?);

  return IndexedStack(
    index: index,
    alignment: alignment,
    children: buildAllChildren(node, buildChild),
  );
}

Widget buildServerDecoratedBox(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final decoration = parseBoxDecoration(node.props['decoration'] as Map<String, dynamic>?);

  return DecoratedBox(
    decoration: decoration,
    child: buildSingleChild(node, buildChild),
  );
}

Widget buildServerTransform(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final type = node.props['transformType'] as String? ?? 'rotate';
  final alignment = parseAlignment(node.props['alignment'] as String?);

  final child = buildSingleChild(node, buildChild);

  return switch (type) {
    'rotate' => Transform.rotate(
        angle: (node.props['angle'] as num?)?.toDouble() ?? 0,
        alignment: alignment,
        child: child,
      ),
    'scale' => Transform.scale(
        scale: (node.props['scale'] as num?)?.toDouble() ?? 1.0,
        scaleX: (node.props['scaleX'] as num?)?.toDouble(),
        scaleY: (node.props['scaleY'] as num?)?.toDouble(),
        alignment: alignment,
        child: child,
      ),
    'translate' => Transform.translate(
        offset: Offset(
          (node.props['offsetX'] as num?)?.toDouble() ?? 0,
          (node.props['offsetY'] as num?)?.toDouble() ?? 0,
        ),
        child: child,
      ),
    'flip' => Transform(
        alignment: alignment,
        transform: Matrix4.identity()
          ..rotateY(node.props['flipX'] == true ? math.pi : 0)
          ..rotateX(node.props['flipY'] == true ? math.pi : 0),
        child: child,
      ),
    _ => child,
  };
}

Widget buildServerBackdropFilter(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final sigmaX = (node.props['sigmaX'] as num?)?.toDouble() ?? 0;
  final sigmaY = (node.props['sigmaY'] as num?)?.toDouble() ?? 0;

  return ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
      child: buildSingleChild(node, buildChild),
    ),
  );
}

Widget buildServerBanner(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final message = node.props['message'] as String? ?? '';
  final color = parseHexColor(node.props['color'] as String?) ?? Colors.red;
  final location = switch (node.props['location'] as String?) {
    'topStart' => BannerLocation.topStart,
    'topEnd' => BannerLocation.topEnd,
    'bottomStart' => BannerLocation.bottomStart,
    'bottomEnd' => BannerLocation.bottomEnd,
    _ => BannerLocation.topEnd,
  };

  return Banner(
    message: message,
    color: color,
    location: location,
    child: buildSingleChild(node, buildChild),
  );
}
