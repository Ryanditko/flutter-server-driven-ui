import 'package:flutter/material.dart';

import '../models/screen_contract.dart';
import 'color_utils.dart';

EdgeInsets? parsePadding(dynamic raw) {
  if (raw == null) return null;
  if (raw is Map<String, dynamic>) {
    final model = EdgeInsetsModel.fromJson(raw);
    return EdgeInsets.fromLTRB(model.left, model.top, model.right, model.bottom);
  }
  if (raw is num) {
    return EdgeInsets.all(raw.toDouble());
  }
  return null;
}

AlignmentGeometry parseAlignment(String? value) {
  return switch (value) {
    'topLeft' => Alignment.topLeft,
    'topCenter' => Alignment.topCenter,
    'topRight' => Alignment.topRight,
    'centerLeft' => Alignment.centerLeft,
    'center' => Alignment.center,
    'centerRight' => Alignment.centerRight,
    'bottomLeft' => Alignment.bottomLeft,
    'bottomCenter' => Alignment.bottomCenter,
    'bottomRight' => Alignment.bottomRight,
    _ => AlignmentDirectional.topStart,
  };
}

MainAxisAlignment parseMainAxisAlignment(String? value) {
  return switch (value) {
    'center' => MainAxisAlignment.center,
    'start' => MainAxisAlignment.start,
    'end' => MainAxisAlignment.end,
    'spaceBetween' => MainAxisAlignment.spaceBetween,
    'spaceAround' => MainAxisAlignment.spaceAround,
    'spaceEvenly' => MainAxisAlignment.spaceEvenly,
    _ => MainAxisAlignment.start,
  };
}

CrossAxisAlignment parseCrossAxisAlignment(String? value) {
  return switch (value) {
    'center' => CrossAxisAlignment.center,
    'start' => CrossAxisAlignment.start,
    'end' => CrossAxisAlignment.end,
    'stretch' => CrossAxisAlignment.stretch,
    _ => CrossAxisAlignment.start,
  };
}

MainAxisSize parseMainAxisSize(String? value) {
  return switch (value) {
    'max' => MainAxisSize.max,
    'min' => MainAxisSize.min,
    _ => MainAxisSize.min,
  };
}

Axis parseAxis(String? value) {
  return switch (value) {
    'horizontal' => Axis.horizontal,
    'vertical' => Axis.vertical,
    _ => Axis.vertical,
  };
}

TextAlign? parseTextAlign(String? a) {
  return switch (a) {
    'center' => TextAlign.center,
    'right' => TextAlign.right,
    'left' => TextAlign.left,
    'justify' => TextAlign.justify,
    'start' => TextAlign.start,
    'end' => TextAlign.end,
    _ => null,
  };
}

FontWeight? parseFontWeight(String? w) {
  return switch (w) {
    'bold' || 'w700' => FontWeight.w700,
    'w100' => FontWeight.w100,
    'w200' => FontWeight.w200,
    'w300' => FontWeight.w300,
    'w400' || 'normal' => FontWeight.w400,
    'w500' => FontWeight.w500,
    'w600' => FontWeight.w600,
    'w800' => FontWeight.w800,
    'w900' => FontWeight.w900,
    _ => null,
  };
}

FontStyle? parseFontStyle(String? value) {
  return switch (value) {
    'italic' => FontStyle.italic,
    'normal' => FontStyle.normal,
    _ => null,
  };
}

TextDecoration? parseTextDecoration(String? value) {
  return switch (value) {
    'underline' => TextDecoration.underline,
    'lineThrough' => TextDecoration.lineThrough,
    'overline' => TextDecoration.overline,
    'none' => TextDecoration.none,
    _ => null,
  };
}

TextOverflow? parseTextOverflow(String? value) {
  return switch (value) {
    'ellipsis' => TextOverflow.ellipsis,
    'clip' => TextOverflow.clip,
    'fade' => TextOverflow.fade,
    'visible' => TextOverflow.visible,
    _ => null,
  };
}

BoxFit parseBoxFit(String? value) {
  return switch (value) {
    'cover' => BoxFit.cover,
    'contain' => BoxFit.contain,
    'fill' => BoxFit.fill,
    'fitWidth' => BoxFit.fitWidth,
    'fitHeight' => BoxFit.fitHeight,
    'none' => BoxFit.none,
    'scaleDown' => BoxFit.scaleDown,
    _ => BoxFit.contain,
  };
}

StackFit parseStackFit(String? value) {
  return switch (value) {
    'expand' => StackFit.expand,
    'loose' => StackFit.loose,
    'passthrough' => StackFit.passthrough,
    _ => StackFit.loose,
  };
}

Clip parseClipBehavior(String? value) {
  return switch (value) {
    'none' => Clip.none,
    'hardEdge' => Clip.hardEdge,
    'antiAlias' => Clip.antiAlias,
    'antiAliasWithSaveLayer' => Clip.antiAliasWithSaveLayer,
    _ => Clip.hardEdge,
  };
}

BorderRadius? parseBorderRadius(dynamic raw) {
  if (raw == null) return null;
  if (raw is num) return BorderRadius.circular(raw.toDouble());
  if (raw is Map<String, dynamic>) {
    return BorderRadius.only(
      topLeft: Radius.circular((raw['topLeft'] as num?)?.toDouble() ?? 0),
      topRight: Radius.circular((raw['topRight'] as num?)?.toDouble() ?? 0),
      bottomLeft: Radius.circular((raw['bottomLeft'] as num?)?.toDouble() ?? 0),
      bottomRight: Radius.circular((raw['bottomRight'] as num?)?.toDouble() ?? 0),
    );
  }
  return null;
}

BoxConstraints? parseBoxConstraints(Map<String, dynamic>? raw) {
  if (raw == null) return null;
  return BoxConstraints(
    minWidth: (raw['minWidth'] as num?)?.toDouble() ?? 0,
    maxWidth: (raw['maxWidth'] as num?)?.toDouble() ?? double.infinity,
    minHeight: (raw['minHeight'] as num?)?.toDouble() ?? 0,
    maxHeight: (raw['maxHeight'] as num?)?.toDouble() ?? double.infinity,
  );
}

BoxDecoration parseBoxDecoration(Map<String, dynamic>? raw) {
  if (raw == null) return const BoxDecoration();

  final bgColor = parseHexColor(raw['color'] as String?);
  final borderRadius = parseBorderRadius(raw['borderRadius']);
  final gradient = _parseGradient(raw['gradient'] as Map<String, dynamic>?);
  final border = _parseBorder(raw['border'] as Map<String, dynamic>?);
  final boxShadow = _parseBoxShadows(raw['boxShadow'] as List<dynamic>?);

  return BoxDecoration(
    color: gradient == null ? bgColor : null,
    borderRadius: borderRadius,
    gradient: gradient,
    border: border,
    boxShadow: boxShadow,
  );
}

Gradient? _parseGradient(Map<String, dynamic>? raw) {
  if (raw == null) return null;

  final type = raw['type'] as String? ?? 'linear';
  final colors = (raw['colors'] as List<dynamic>?)
          ?.map((c) => parseHexColor(c as String))
          .whereType<Color>()
          .toList() ??
      [];
  if (colors.length < 2) return null;

  final stops = (raw['stops'] as List<dynamic>?)?.map((s) => (s as num).toDouble()).toList();
  final begin = parseAlignment(raw['begin'] as String?) as Alignment;
  final end = parseAlignment(raw['end'] as String?) as Alignment;

  return switch (type) {
    'radial' => RadialGradient(colors: colors, stops: stops, center: begin),
    'sweep' => SweepGradient(colors: colors, stops: stops, center: begin),
    _ => LinearGradient(colors: colors, stops: stops, begin: begin, end: end),
  };
}

Border? _parseBorder(Map<String, dynamic>? raw) {
  if (raw == null) return null;
  final color = parseHexColor(raw['color'] as String?) ?? Colors.black;
  final width = (raw['width'] as num?)?.toDouble() ?? 1;
  final style = (raw['style'] as String?) == 'none' ? BorderStyle.none : BorderStyle.solid;
  return Border.all(color: color, width: width, style: style);
}

List<BoxShadow>? _parseBoxShadows(List<dynamic>? raw) {
  if (raw == null || raw.isEmpty) return null;
  return raw.map((s) {
    final m = s as Map<String, dynamic>;
    return BoxShadow(
      color: parseHexColor(m['color'] as String?) ?? Colors.black26,
      blurRadius: (m['blurRadius'] as num?)?.toDouble() ?? 0,
      spreadRadius: (m['spreadRadius'] as num?)?.toDouble() ?? 0,
      offset: Offset(
        (m['offsetX'] as num?)?.toDouble() ?? 0,
        (m['offsetY'] as num?)?.toDouble() ?? 0,
      ),
    );
  }).toList();
}

Duration parseDuration(dynamic raw, {Duration fallback = const Duration(milliseconds: 300)}) {
  if (raw is num) return Duration(milliseconds: raw.toInt());
  return fallback;
}

Curve parseCurve(String? value) {
  return switch (value) {
    'linear' => Curves.linear,
    'easeIn' => Curves.easeIn,
    'easeOut' => Curves.easeOut,
    'easeInOut' => Curves.easeInOut,
    'bounceIn' => Curves.bounceIn,
    'bounceOut' => Curves.bounceOut,
    'elasticIn' => Curves.elasticIn,
    'elasticOut' => Curves.elasticOut,
    'decelerate' => Curves.decelerate,
    'fastOutSlowIn' => Curves.fastOutSlowIn,
    _ => Curves.easeInOut,
  };
}

VerticalDirection parseVerticalDirection(String? value) {
  return switch (value) {
    'up' => VerticalDirection.up,
    'down' => VerticalDirection.down,
    _ => VerticalDirection.down,
  };
}

TextDirection? parseTextDirection(String? value) {
  return switch (value) {
    'ltr' => TextDirection.ltr,
    'rtl' => TextDirection.rtl,
    _ => null,
  };
}

ScrollPhysics? parseScrollPhysics(String? value) {
  return switch (value) {
    'bouncing' => const BouncingScrollPhysics(),
    'clamping' => const ClampingScrollPhysics(),
    'never' => const NeverScrollableScrollPhysics(),
    'always' => const AlwaysScrollableScrollPhysics(),
    _ => null,
  };
}

TableCellVerticalAlignment parseTableCellVerticalAlignment(String? value) {
  return switch (value) {
    'top' => TableCellVerticalAlignment.top,
    'middle' => TableCellVerticalAlignment.middle,
    'bottom' => TableCellVerticalAlignment.bottom,
    'baseline' => TableCellVerticalAlignment.baseline,
    'fill' => TableCellVerticalAlignment.fill,
    _ => TableCellVerticalAlignment.top,
  };
}

Widget buildSingleChild(
  ComponentNode node,
  Widget Function(ComponentNode) buildChild,
) {
  return node.children.isNotEmpty ? buildChild(node.children.first) : const SizedBox.shrink();
}

List<Widget> buildAllChildren(
  ComponentNode node,
  Widget Function(ComponentNode) buildChild,
) {
  return node.children.map(buildChild).toList();
}
