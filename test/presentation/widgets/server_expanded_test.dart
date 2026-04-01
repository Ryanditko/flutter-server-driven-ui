import 'package:flutter/material.dart';
import 'package:flutter_backend_driven_ui/core/models/screen_contract.dart';
import 'package:flutter_backend_driven_ui/presentation/widgets/server_expanded.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _childBuilder(ComponentNode c) =>
    Text(c.props['content'] as String? ?? 'child');

void main() {
  testWidgets('buildServerExpanded wraps child in Expanded with flex', (tester) async {
    final node = ComponentNode(
      type: 'expanded',
      props: const {'flex': 2},
      children: const [ComponentNode(type: 'text', props: {'content': 'Hi'})],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: [Builder(builder: (ctx) => buildServerExpanded(node, ctx, _childBuilder))],
          ),
        ),
      ),
    );

    final expanded = tester.widget<Expanded>(find.byType(Expanded));
    expect(expanded.flex, 2);
    expect(find.text('Hi'), findsOneWidget);
  });

  testWidgets('buildServerFlexible wraps child with fit and flex', (tester) async {
    final node = ComponentNode(
      type: 'flexible',
      props: const {'flex': 3, 'fit': 'tight'},
      children: const [ComponentNode(type: 'text', props: {'content': 'Flex'})],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: [Builder(builder: (ctx) => buildServerFlexible(node, ctx, _childBuilder))],
          ),
        ),
      ),
    );

    final flexible = tester.widget<Flexible>(find.byType(Flexible));
    expect(flexible.flex, 3);
    expect(flexible.fit, FlexFit.tight);
  });

  testWidgets('buildServerExpanded defaults to flex 1', (tester) async {
    final node = ComponentNode(
      type: 'expanded',
      props: const {},
      children: const [ComponentNode(type: 'text', props: {'content': 'Default'})],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: [Builder(builder: (ctx) => buildServerExpanded(node, ctx, _childBuilder))],
          ),
        ),
      ),
    );

    final expanded = tester.widget<Expanded>(find.byType(Expanded));
    expect(expanded.flex, 1);
  });
}
