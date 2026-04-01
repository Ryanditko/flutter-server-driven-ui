import 'package:flutter/material.dart';

import '../../core/models/screen_contract.dart';
import '../../core/utils/parsing_utils.dart';

Widget buildServerScrollView(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final padding = parsePadding(node.props['padding']);
  final scrollDirection = parseAxis(node.props['scrollDirection'] as String?);
  final reverse = node.props['reverse'] as bool? ?? false;
  final physics = parseScrollPhysics(node.props['physics'] as String?);

  return SingleChildScrollView(
    padding: padding,
    scrollDirection: scrollDirection,
    reverse: reverse,
    physics: physics,
    child: scrollDirection == Axis.horizontal
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: buildAllChildren(node, buildChild),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: buildAllChildren(node, buildChild),
          ),
  );
}

Widget buildServerGridView(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final crossAxisCount = (node.props['crossAxisCount'] as num?)?.toInt() ?? 2;
  final mainAxisSpacing = (node.props['mainAxisSpacing'] as num?)?.toDouble() ?? 0;
  final crossAxisSpacing = (node.props['crossAxisSpacing'] as num?)?.toDouble() ?? 0;
  final childAspectRatio = (node.props['childAspectRatio'] as num?)?.toDouble() ?? 1.0;
  final padding = parsePadding(node.props['padding']);
  final shrinkWrap = node.props['shrinkWrap'] as bool? ?? true;
  final physics = parseScrollPhysics(node.props['physics'] as String?) ??
      const NeverScrollableScrollPhysics();
  final scrollDirection = parseAxis(node.props['scrollDirection'] as String?);

  return GridView.count(
    crossAxisCount: crossAxisCount,
    mainAxisSpacing: mainAxisSpacing,
    crossAxisSpacing: crossAxisSpacing,
    childAspectRatio: childAspectRatio,
    padding: padding,
    shrinkWrap: shrinkWrap,
    physics: physics,
    scrollDirection: scrollDirection,
    children: buildAllChildren(node, buildChild),
  );
}

Widget buildServerPageView(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final scrollDirection = parseAxis(node.props['scrollDirection'] as String?);
  final reverse = node.props['reverse'] as bool? ?? false;
  final pageSnapping = node.props['pageSnapping'] as bool? ?? true;
  final physics = parseScrollPhysics(node.props['physics'] as String?);

  return SizedBox(
    height: (node.props['height'] as num?)?.toDouble() ?? 200,
    child: PageView(
      scrollDirection: scrollDirection,
      reverse: reverse,
      pageSnapping: pageSnapping,
      physics: physics,
      children: buildAllChildren(node, buildChild),
    ),
  );
}

Widget buildServerCustomScrollView(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final scrollDirection = parseAxis(node.props['scrollDirection'] as String?);
  final reverse = node.props['reverse'] as bool? ?? false;
  final physics = parseScrollPhysics(node.props['physics'] as String?);
  final shrinkWrap = node.props['shrinkWrap'] as bool? ?? false;

  return CustomScrollView(
    scrollDirection: scrollDirection,
    reverse: reverse,
    physics: physics,
    shrinkWrap: shrinkWrap,
    slivers: [
      SliverList(
        delegate: SliverChildListDelegate(
          buildAllChildren(node, buildChild),
        ),
      ),
    ],
  );
}

Widget buildServerSliverList(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  return SliverList(
    delegate: SliverChildListDelegate(
      buildAllChildren(node, buildChild),
    ),
  );
}

Widget buildServerSliverGrid(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final crossAxisCount = (node.props['crossAxisCount'] as num?)?.toInt() ?? 2;
  final mainAxisSpacing = (node.props['mainAxisSpacing'] as num?)?.toDouble() ?? 0;
  final crossAxisSpacing = (node.props['crossAxisSpacing'] as num?)?.toDouble() ?? 0;
  final childAspectRatio = (node.props['childAspectRatio'] as num?)?.toDouble() ?? 1.0;

  return SliverGrid(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: childAspectRatio,
    ),
    delegate: SliverChildListDelegate(
      buildAllChildren(node, buildChild),
    ),
  );
}
