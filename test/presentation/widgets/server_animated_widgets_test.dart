import 'package:flutter/material.dart';
import 'package:flutter_backend_driven_ui/core/models/screen_contract.dart';
import 'package:flutter_backend_driven_ui/presentation/widgets/server_animated_widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget Function(BuildContext) builder) {
  return MaterialApp(
    home: Scaffold(body: Builder(builder: builder)),
  );
}

Widget _childBuilder(ComponentNode c) => const Text('child');

void main() {
  testWidgets('buildServerAnimatedContainer renders', (tester) async {
    final node = ComponentNode(
      type: 'animatedContainer',
      props: const {'duration': 300, 'width': 100, 'height': 100},
      children: [const ComponentNode(type: 'text', props: {'content': 'hi'})],
    );

    await tester
        .pumpWidget(_wrap((ctx) => buildServerAnimatedContainer(node, ctx, _childBuilder)));

    expect(find.byType(AnimatedContainer), findsOneWidget);
  });

  testWidgets('buildServerAnimatedOpacity renders with opacity', (tester) async {
    final node = ComponentNode(
      type: 'animatedOpacity',
      props: const {'opacity': 0.5, 'duration': 200},
      children: [const ComponentNode(type: 'text', props: {'content': 'hi'})],
    );

    await tester
        .pumpWidget(_wrap((ctx) => buildServerAnimatedOpacity(node, ctx, _childBuilder)));

    final widget = tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity));
    expect(widget.opacity, 0.5);
  });

  testWidgets('buildServerAnimatedCrossFade shows first child', (tester) async {
    final node = ComponentNode(
      type: 'animatedCrossFade',
      props: const {'showFirst': true, 'duration': 200},
      children: [
        const ComponentNode(type: 'text', props: {'content': 'first'}),
        const ComponentNode(type: 'text', props: {'content': 'second'}),
      ],
    );

    await tester
        .pumpWidget(_wrap((ctx) => buildServerAnimatedCrossFade(node, ctx, _childBuilder)));

    expect(find.byType(AnimatedCrossFade), findsOneWidget);
  });

  testWidgets('buildServerAnimatedSwitcher renders', (tester) async {
    final node = ComponentNode(
      type: 'animatedSwitcher',
      props: const {'duration': 300},
      children: [const ComponentNode(type: 'text', props: {'content': 'hi'})],
    );

    await tester
        .pumpWidget(_wrap((ctx) => buildServerAnimatedSwitcher(node, ctx, _childBuilder)));

    expect(find.byType(AnimatedSwitcher), findsOneWidget);
  });

  testWidgets('buildServerAnimatedSize renders', (tester) async {
    final node = ComponentNode(
      type: 'animatedSize',
      props: const {'duration': 300},
      children: [const ComponentNode(type: 'text', props: {'content': 'hi'})],
    );

    await tester
        .pumpWidget(_wrap((ctx) => buildServerAnimatedSize(node, ctx, _childBuilder)));

    expect(find.byType(AnimatedSize), findsOneWidget);
  });
}
