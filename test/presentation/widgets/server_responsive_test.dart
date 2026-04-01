import 'package:flutter/material.dart';
import 'package:flutter_backend_driven_ui/core/models/screen_contract.dart';
import 'package:flutter_backend_driven_ui/presentation/widgets/server_responsive.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _childBuilder(ComponentNode c) =>
    Text(c.props['content'] as String? ?? 'child');

void main() {
  testWidgets('responsive selects compact child on narrow screen', (tester) async {
    tester.view.physicalSize = const Size(300, 600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final node = ComponentNode(
      type: 'responsive',
      props: const {'compact': 0, 'medium': 1},
      children: const [
        ComponentNode(type: 'text', props: {'content': 'Compact'}),
        ComponentNode(type: 'text', props: {'content': 'Medium'}),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Builder(builder: (ctx) => buildServerResponsive(node, ctx, _childBuilder))),
      ),
    );

    expect(find.text('Compact'), findsOneWidget);
    expect(find.text('Medium'), findsNothing);
  });

  testWidgets('responsive falls back to compact when medium is not set', (tester) async {
    tester.view.physicalSize = const Size(700, 600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final node = ComponentNode(
      type: 'responsive',
      props: const {'compact': 0},
      children: const [
        ComponentNode(type: 'text', props: {'content': 'Fallback'}),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Builder(builder: (ctx) => buildServerResponsive(node, ctx, _childBuilder))),
      ),
    );

    expect(find.text('Fallback'), findsOneWidget);
  });

  testWidgets('responsive returns SizedBox when index is out of bounds', (tester) async {
    final node = ComponentNode(
      type: 'responsive',
      props: const {'compact': 5},
      children: const [
        ComponentNode(type: 'text', props: {'content': 'Only'}),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Builder(builder: (ctx) => buildServerResponsive(node, ctx, _childBuilder))),
      ),
    );

    expect(find.byType(SizedBox), findsWidgets);
  });
}
