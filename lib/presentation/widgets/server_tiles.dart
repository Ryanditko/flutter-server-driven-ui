import 'package:flutter/material.dart';

import '../../core/models/screen_contract.dart';
import '../../core/utils/color_utils.dart';
import '../../core/utils/parsing_utils.dart';
import 'server_button.dart';
import 'server_icon.dart' show resolveIcon;

Widget buildServerListTile(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final title = node.props['title'] as String? ?? '';
  final subtitle = node.props['subtitle'] as String?;
  final leadingIcon = node.props['leadingIcon'] as String?;
  final trailingIcon = node.props['trailingIcon'] as String?;
  final leadingImageUrl = node.props['leadingImageUrl'] as String?;
  final dense = node.props['dense'] as bool? ?? false;
  final isThreeLine = node.props['isThreeLine'] as bool? ?? false;
  final enabled = node.props['enabled'] as bool? ?? true;
  final selected = node.props['selected'] as bool? ?? false;
  final tileColor = parseHexColor(node.props['tileColor'] as String?);
  final contentPadding = parsePadding(node.props['contentPadding']);

  Widget? leading;
  if (leadingImageUrl != null) {
    leading = CircleAvatar(backgroundImage: NetworkImage(leadingImageUrl));
  } else if (leadingIcon != null) {
    leading = Icon(resolveIcon(leadingIcon));
  }

  Widget? trailing;
  if (trailingIcon != null) {
    trailing = Icon(resolveIcon(trailingIcon));
  } else if (node.children.isNotEmpty) {
    trailing = buildChild(node.children.first);
  }

  return ListTile(
    title: Text(title),
    subtitle: subtitle != null ? Text(subtitle) : null,
    leading: leading,
    trailing: trailing,
    dense: dense,
    isThreeLine: isThreeLine,
    enabled: enabled,
    selected: selected,
    tileColor: tileColor,
    contentPadding: contentPadding,
    onTap: node.action != null ? () => handleAction(context, node.action) : null,
  );
}

Widget buildServerExpansionTile(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final title = node.props['title'] as String? ?? '';
  final subtitle = node.props['subtitle'] as String?;
  final leadingIcon = node.props['leadingIcon'] as String?;
  final initiallyExpanded = node.props['initiallyExpanded'] as bool? ?? false;
  final tilePadding = parsePadding(node.props['tilePadding']);
  final childrenPadding = parsePadding(node.props['childrenPadding']);
  final bgColor = parseHexColor(node.props['backgroundColor'] as String?);
  final collapsedBgColor = parseHexColor(node.props['collapsedBackgroundColor'] as String?);
  final iconColor = parseHexColor(node.props['iconColor'] as String?);

  return ExpansionTile(
    title: Text(title),
    subtitle: subtitle != null ? Text(subtitle) : null,
    leading: leadingIcon != null ? Icon(resolveIcon(leadingIcon)) : null,
    initiallyExpanded: initiallyExpanded,
    tilePadding: tilePadding,
    childrenPadding: childrenPadding,
    backgroundColor: bgColor,
    collapsedBackgroundColor: collapsedBgColor,
    iconColor: iconColor,
    children: buildAllChildren(node, buildChild),
  );
}

Widget buildServerSwitchListTile(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild, {
  void Function(String id, String value)? onChanged,
}) {
  final title = node.props['title'] as String? ?? '';
  final subtitle = node.props['subtitle'] as String?;
  final value = node.props['value'] as bool? ?? false;
  final dense = node.props['dense'] as bool? ?? false;
  final secondary = node.props['leadingIcon'] as String?;

  return _SwitchListTileWidget(
    nodeId: node.id,
    title: title,
    subtitle: subtitle,
    initialValue: value,
    dense: dense,
    secondaryIcon: secondary,
    onChanged: onChanged,
  );
}

class _SwitchListTileWidget extends StatefulWidget {
  final String? nodeId;
  final String title;
  final String? subtitle;
  final bool initialValue;
  final bool dense;
  final String? secondaryIcon;
  final void Function(String id, String value)? onChanged;

  const _SwitchListTileWidget({
    required this.nodeId,
    required this.title,
    this.subtitle,
    required this.initialValue,
    required this.dense,
    this.secondaryIcon,
    this.onChanged,
  });

  @override
  State<_SwitchListTileWidget> createState() => _SwitchListTileWidgetState();
}

class _SwitchListTileWidgetState extends State<_SwitchListTileWidget> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(widget.title),
      subtitle: widget.subtitle != null ? Text(widget.subtitle!) : null,
      value: _value,
      dense: widget.dense,
      secondary: widget.secondaryIcon != null ? Icon(resolveIcon(widget.secondaryIcon!)) : null,
      onChanged: (v) {
        setState(() => _value = v);
        if (widget.nodeId != null) {
          widget.onChanged?.call(widget.nodeId!, v.toString());
        }
      },
    );
  }
}

Widget buildServerCheckboxListTile(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild, {
  void Function(String id, String value)? onChanged,
}) {
  final title = node.props['title'] as String? ?? '';
  final subtitle = node.props['subtitle'] as String?;
  final value = node.props['value'] as bool? ?? false;
  final dense = node.props['dense'] as bool? ?? false;
  final secondary = node.props['leadingIcon'] as String?;

  return _CheckboxListTileWidget(
    nodeId: node.id,
    title: title,
    subtitle: subtitle,
    initialValue: value,
    dense: dense,
    secondaryIcon: secondary,
    onChanged: onChanged,
  );
}

class _CheckboxListTileWidget extends StatefulWidget {
  final String? nodeId;
  final String title;
  final String? subtitle;
  final bool initialValue;
  final bool dense;
  final String? secondaryIcon;
  final void Function(String id, String value)? onChanged;

  const _CheckboxListTileWidget({
    required this.nodeId,
    required this.title,
    this.subtitle,
    required this.initialValue,
    required this.dense,
    this.secondaryIcon,
    this.onChanged,
  });

  @override
  State<_CheckboxListTileWidget> createState() => _CheckboxListTileWidgetState();
}

class _CheckboxListTileWidgetState extends State<_CheckboxListTileWidget> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title),
      subtitle: widget.subtitle != null ? Text(widget.subtitle!) : null,
      value: _value,
      dense: widget.dense,
      secondary: widget.secondaryIcon != null ? Icon(resolveIcon(widget.secondaryIcon!)) : null,
      onChanged: (v) {
        setState(() => _value = v ?? false);
        if (widget.nodeId != null) {
          widget.onChanged?.call(widget.nodeId!, (v ?? false).toString());
        }
      },
    );
  }
}

Widget buildServerRadioListTile(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild, {
  void Function(String id, String value)? onChanged,
}) {
  final title = node.props['title'] as String? ?? '';
  final subtitle = node.props['subtitle'] as String?;
  final value = node.props['value'] as String? ?? '';
  final groupValue = node.props['groupValue'] as String? ?? '';
  final dense = node.props['dense'] as bool? ?? false;

  return _RadioListTileWidget(
    nodeId: node.id,
    title: title,
    subtitle: subtitle,
    value: value,
    groupValue: groupValue,
    dense: dense,
    onChanged: onChanged,
  );
}

class _RadioListTileWidget extends StatefulWidget {
  final String? nodeId;
  final String title;
  final String? subtitle;
  final String value;
  final String groupValue;
  final bool dense;
  final void Function(String id, String value)? onChanged;

  const _RadioListTileWidget({
    required this.nodeId,
    required this.title,
    this.subtitle,
    required this.value,
    required this.groupValue,
    required this.dense,
    this.onChanged,
  });

  @override
  State<_RadioListTileWidget> createState() => _RadioListTileWidgetState();
}

class _RadioListTileWidgetState extends State<_RadioListTileWidget> {
  late String _groupValue;

  @override
  void initState() {
    super.initState();
    _groupValue = widget.groupValue;
  }

  @override
  Widget build(BuildContext context) {
    return RadioGroup<String>(
      groupValue: _groupValue,
      onChanged: (v) {
        setState(() => _groupValue = v ?? '');
        if (widget.nodeId != null) {
          widget.onChanged?.call(widget.nodeId!, v ?? '');
        }
      },
      child: RadioListTile<String>(
        title: Text(widget.title),
        subtitle: widget.subtitle != null ? Text(widget.subtitle!) : null,
        value: widget.value,
        dense: widget.dense,
      ),
    );
  }
}
