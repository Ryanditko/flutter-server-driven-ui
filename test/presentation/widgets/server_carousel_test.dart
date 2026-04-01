import 'package:flutter/material.dart';
import 'package:flutter_backend_driven_ui/core/models/screen_contract.dart';
import 'package:flutter_backend_driven_ui/presentation/widgets/server_carousel.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget Function(BuildContext) builder) {
  return MaterialApp(
    home: Scaffold(body: Builder(builder: builder)),
  );
}

Widget _childBuilder(ComponentNode c) =>
    Text(c.props['content'] as String? ?? 'slide');

void main() {
  testWidgets('carousel renders PageView with given height', (tester) async {
    final node = ComponentNode(
      type: 'carousel',
      props: const {'height': 150},
      children: const [
        ComponentNode(type: 'text', props: {'content': 'A'}),
        ComponentNode(type: 'text', props: {'content': 'B'}),
      ],
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerCarousel(node, ctx, _childBuilder)));

    expect(find.byType(PageView), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
  });

  testWidgets('carousel renders dot indicators for multiple slides', (tester) async {
    final node = ComponentNode(
      type: 'carousel',
      props: const {'height': 100},
      children: const [
        ComponentNode(type: 'text', props: {'content': 'S1'}),
        ComponentNode(type: 'text', props: {'content': 'S2'}),
        ComponentNode(type: 'text', props: {'content': 'S3'}),
      ],
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerCarousel(node, ctx, _childBuilder)));
    await tester.pumpAndSettle();

    expect(find.byType(AnimatedContainer), findsNWidgets(3));
  });

  testWidgets('single-slide carousel hides dot indicators', (tester) async {
    final node = ComponentNode(
      type: 'carousel',
      props: const {'height': 100},
      children: const [
        ComponentNode(type: 'text', props: {'content': 'Only'}),
      ],
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerCarousel(node, ctx, _childBuilder)));

    expect(find.byType(AnimatedContainer), findsNothing);
  });
}
