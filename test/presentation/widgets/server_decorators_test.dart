import 'package:flutter/material.dart';
import 'package:flutter_backend_driven_ui/core/models/screen_contract.dart';
import 'package:flutter_backend_driven_ui/presentation/widgets/server_decorators.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget Function(BuildContext) builder) {
  return MaterialApp(
    home: Scaffold(body: Builder(builder: builder)),
  );
}

Widget _childBuilder(ComponentNode c) => const Text('child');

void main() {
  testWidgets('buildServerMaterial renders Material widget', (tester) async {
    final node = ComponentNode(
      type: 'material',
      props: const {'elevation': 4},
      children: [const ComponentNode(type: 'text', props: {'content': 'hi'})],
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerMaterial(node, ctx, _childBuilder)));

    expect(find.text('child'), findsOneWidget);
  });

  testWidgets('buildServerHero renders Hero with tag', (tester) async {
    final node = ComponentNode(
      type: 'hero',
      props: const {'tag': 'avatar'},
      children: [const ComponentNode(type: 'text', props: {'content': 'hi'})],
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerHero(node, ctx, _childBuilder)));

    final hero = tester.widget<Hero>(find.byType(Hero));
    expect(hero.tag, 'avatar');
  });

  testWidgets('buildServerIndexedStack shows child at index', (tester) async {
    final node = ComponentNode(
      type: 'indexedStack',
      props: const {'index': 0},
      children: [
        const ComponentNode(type: 'text', props: {'content': 'first'}),
        const ComponentNode(type: 'text', props: {'content': 'second'}),
      ],
    );

    await tester
        .pumpWidget(_wrap((ctx) => buildServerIndexedStack(node, ctx, _childBuilder)));

    expect(find.byType(IndexedStack), findsOneWidget);
  });

  testWidgets('buildServerTransform rotate renders Transform', (tester) async {
    final node = ComponentNode(
      type: 'transform',
      props: const {'transformType': 'rotate', 'angle': 1.57},
      children: [const ComponentNode(type: 'text', props: {'content': 'hi'})],
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerTransform(node, ctx, _childBuilder)));

    expect(find.text('child'), findsOneWidget);
  });

  testWidgets('buildServerTransform scale renders child', (tester) async {
    final node = ComponentNode(
      type: 'transform',
      props: const {'transformType': 'scale', 'scale': 2.0},
      children: [const ComponentNode(type: 'text', props: {'content': 'hi'})],
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerTransform(node, ctx, _childBuilder)));

    expect(find.text('child'), findsOneWidget);
  });

  testWidgets('buildServerBanner renders child with banner overlay', (tester) async {
    final node = ComponentNode(
      type: 'banner',
      props: const {'message': 'BETA', 'location': 'topEnd'},
      children: [const ComponentNode(type: 'text', props: {'content': 'hi'})],
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerBanner(node, ctx, _childBuilder)));

    expect(find.text('child'), findsOneWidget);
  });
}
