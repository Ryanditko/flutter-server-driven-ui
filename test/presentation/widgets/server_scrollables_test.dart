import 'package:flutter/material.dart';
import 'package:flutter_backend_driven_ui/core/models/screen_contract.dart';
import 'package:flutter_backend_driven_ui/presentation/widgets/server_scrollables.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget Function(BuildContext) builder) {
  return MaterialApp(
    home: Scaffold(body: Builder(builder: builder)),
  );
}

Widget _childBuilder(ComponentNode c) => const SizedBox(height: 50, child: Text('item'));

void main() {
  testWidgets('buildServerScrollView renders SingleChildScrollView', (tester) async {
    final node = ComponentNode(
      type: 'scrollView',
      children: [
        const ComponentNode(type: 'text', props: {'content': 'a'}),
        const ComponentNode(type: 'text', props: {'content': 'b'}),
      ],
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerScrollView(node, ctx, _childBuilder)));

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.text('item'), findsNWidgets(2));
  });

  testWidgets('buildServerGridView renders with crossAxisCount', (tester) async {
    final node = ComponentNode(
      type: 'gridView',
      props: const {'crossAxisCount': 3, 'crossAxisSpacing': 8, 'mainAxisSpacing': 8},
      children: List.generate(
        6,
        (_) => const ComponentNode(type: 'text', props: {'content': 'cell'}),
      ),
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerGridView(node, ctx, _childBuilder)));

    expect(find.byType(GridView), findsOneWidget);
    expect(find.text('item'), findsNWidgets(6));
  });

  testWidgets('buildServerPageView renders PageView with height', (tester) async {
    final node = ComponentNode(
      type: 'pageView',
      props: const {'height': 150},
      children: [
        const ComponentNode(type: 'text', props: {'content': 'page1'}),
        const ComponentNode(type: 'text', props: {'content': 'page2'}),
      ],
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerPageView(node, ctx, _childBuilder)));

    expect(find.byType(PageView), findsOneWidget);
  });
}
