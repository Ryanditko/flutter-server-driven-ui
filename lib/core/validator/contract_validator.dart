import '../models/screen_contract.dart';

/// Validates a [ScreenContract] against the engine's expectations.
///
/// Returns a list of human-readable issues. An empty list means the
/// contract is valid.
class ContractValidator {
  static const supportedSchemaVersions = {'1.0'};

  static const _layoutTypes = {
    // Core layout
    'column', 'row', 'container', 'card', 'listView', 'stack', 'positioned',
    'wrap', 'responsive', 'expanded', 'flexible', 'tabBar', 'carousel',
    // Layout wrappers
    'center', 'align', 'padding', 'sizedBox', 'aspectRatio', 'fittedBox',
    'constrainedBox', 'fractionalSizedBox', 'safeArea', 'intrinsicHeight',
    'intrinsicWidth', 'limitedBox', 'overflowBox', 'offstage', 'ignorePointer',
    'absorbPointer', 'clipRRect', 'clipOval', 'opacity', 'rotatedBox',
    'coloredBox', 'baseline', 'visibility',
    // Decorators
    'material', 'hero', 'indexedStack', 'decoratedBox', 'transform',
    'backdropFilter', 'banner',
    // Scrollables
    'scrollView', 'gridView', 'pageView', 'customScrollView', 'sliverList',
    'sliverGrid',
    // Interactives
    'inkWell', 'gestureDetector', 'tooltip', 'dismissible', 'draggable',
    'longPressDraggable',
    // Animated
    'animatedContainer', 'animatedOpacity', 'animatedCrossFade',
    'animatedSwitcher', 'animatedAlign', 'animatedPadding',
    'animatedPositioned', 'animatedSize', 'animatedScale', 'fadeTransition',
    // Tiles & tables
    'expansionTile', 'table', 'tableRow', 'tableCell', 'defaultTextStyle',
  };

  static const _leafTypes = {
    // Text
    'text', 'selectableText', 'richText',
    // Buttons
    'button', 'textButton', 'outlinedButton', 'iconButton',
    'floatingActionButton', 'segmentedButton',
    // Media & display
    'image', 'divider', 'verticalDivider', 'icon', 'chip', 'progress',
    'linearProgressIndicator', 'circularProgressIndicator',
    'badge', 'placeholder', 'circleAvatar', 'listTile',
    'popupMenuButton', 'searchBar', 'searchAnchor', 'dataTable',
    // Input
    'input', 'spacer',
    // Interactive input
    'switch', 'checkbox', 'dropdown', 'slider', 'rangeSlider', 'radio',
    'switchListTile', 'checkboxListTile', 'radioListTile',
  };

  static const _actionTypes = {
    'navigate', 'snackbar', 'submit', 'goBack', 'openUrl', 'copyToClipboard', 'showDialog',
  };

  List<String> validate(ScreenContract contract) {
    final issues = <String>[];

    if (!supportedSchemaVersions.contains(contract.schemaVersion)) {
      issues.add(
        'Unsupported schema version "${contract.schemaVersion}". '
        'Supported: ${supportedSchemaVersions.join(", ")}',
      );
    }

    if (contract.screen.id.isEmpty) {
      issues.add('Screen id must not be empty.');
    }
    if (contract.screen.title.isEmpty) {
      issues.add('Screen title must not be empty.');
    }

    _validateNode(contract.screen.root, issues, path: 'root');

    return issues;
  }

  void _validateNode(
    ComponentNode node,
    List<String> issues, {
    required String path,
  }) {
    final allTypes = {..._layoutTypes, ..._leafTypes};

    if (!allTypes.contains(node.type)) {
      issues.add('$path: unknown component type "${node.type}".');
    }

    if (_leafTypes.contains(node.type) && node.children.isNotEmpty) {
      issues.add('$path: leaf component "${node.type}" should not have children.');
    }

    if (node.type == 'text' && node.props['content'] == null) {
      issues.add('$path: text component requires a "content" prop.');
    }

    if (node.type == 'button' && node.props['label'] == null) {
      issues.add('$path: button component requires a "label" prop.');
    }

    if (node.type == 'image' && node.props['url'] == null) {
      issues.add('$path: image component requires a "url" prop.');
    }

    if (node.type == 'input' && (node.id == null || node.id!.isEmpty)) {
      issues.add('$path: input component should have a non-empty "id".');
    }

    if (node.action != null && !_actionTypes.contains(node.action!.type)) {
      issues.add('$path: unknown action type "${node.action!.type}".');
    }

    if (node.action?.type == 'navigate' && node.action?.targetScreenId == null) {
      issues.add('$path: navigate action requires "targetScreenId".');
    }

    for (var i = 0; i < node.children.length; i++) {
      _validateNode(node.children[i], issues, path: '$path.children[$i]');
    }
  }
}
