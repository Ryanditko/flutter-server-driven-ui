import 'package:flutter/material.dart';
import 'package:flutter_backend_driven_ui/core/models/screen_contract.dart';
import 'package:flutter_backend_driven_ui/presentation/widgets/server_tab_bar.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _childBuilder(ComponentNode c) =>
    Text(c.props['content'] as String? ?? 'tab-content');

void main() {
  testWidgets('tab bar renders tabs from props', (tester) async {
    final node = ComponentNode(
      type: 'tabBar',
      props: const {
        'tabs': ['Overview', 'Details'],
      },
      children: const [
        ComponentNode(type: 'text', props: {'content': 'Overview content'}),
        ComponentNode(type: 'text', props: {'content': 'Details content'}),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Builder(builder: (ctx) => buildServerTabBar(node, ctx, _childBuilder))),
      ),
    );

    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Details'), findsOneWidget);
    expect(find.byType(TabBar), findsOneWidget);
  });

  testWidgets('tab bar renders children inside IndexedStack', (tester) async {
    final node = ComponentNode(
      type: 'tabBar',
      props: const {
        'tabs': ['Tab A', 'Tab B'],
      },
      children: const [
        ComponentNode(type: 'text', props: {'content': 'Content A'}),
        ComponentNode(type: 'text', props: {'content': 'Content B'}),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Builder(builder: (ctx) => buildServerTabBar(node, ctx, _childBuilder))),
      ),
    );

    expect(find.byType(IndexedStack), findsOneWidget);
    expect(find.text('Content A'), findsOneWidget);
  });

  testWidgets('tab bar with no tabs renders empty', (tester) async {
    final node = ComponentNode(
      type: 'tabBar',
      props: const {},
      children: const [],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Builder(builder: (ctx) => buildServerTabBar(node, ctx, _childBuilder))),
      ),
    );

    expect(find.byType(TabBar), findsOneWidget);
  });
}
