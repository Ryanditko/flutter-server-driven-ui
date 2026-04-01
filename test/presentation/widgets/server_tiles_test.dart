import 'package:flutter/material.dart';
import 'package:flutter_backend_driven_ui/core/models/screen_contract.dart';
import 'package:flutter_backend_driven_ui/presentation/widgets/server_tiles.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget Function(BuildContext) builder) {
  return MaterialApp(
    home: Scaffold(body: Builder(builder: builder)),
  );
}

Widget _childBuilder(ComponentNode c) => const Text('child');

void main() {
  testWidgets('buildServerListTile renders title and subtitle', (tester) async {
    final node = ComponentNode(
      type: 'listTile',
      props: const {'title': 'Title', 'subtitle': 'Subtitle', 'leadingIcon': 'home'},
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerListTile(node, ctx, _childBuilder)));

    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Subtitle'), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);
  });

  testWidgets('buildServerExpansionTile renders title and children', (tester) async {
    final node = ComponentNode(
      type: 'expansionTile',
      props: const {'title': 'Expand Me', 'initiallyExpanded': true},
      children: [const ComponentNode(type: 'text', props: {'content': 'Inner'})],
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerExpansionTile(node, ctx, _childBuilder)));

    expect(find.text('Expand Me'), findsOneWidget);
    expect(find.byType(ExpansionTile), findsOneWidget);
  });

  testWidgets('buildServerSwitchListTile renders and toggles', (tester) async {
    String? seenId;
    String? seenValue;

    final node = ComponentNode(
      type: 'switchListTile',
      id: 'sw1',
      props: const {'title': 'Toggle', 'value': false},
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerSwitchListTile(
          node, ctx, _childBuilder,
          onChanged: (id, val) {
            seenId = id;
            seenValue = val;
          },
        )));

    expect(find.text('Toggle'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(seenId, 'sw1');
    expect(seenValue, 'true');
  });

  testWidgets('buildServerCheckboxListTile renders and toggles', (tester) async {
    String? seenId;

    final node = ComponentNode(
      type: 'checkboxListTile',
      id: 'cb1',
      props: const {'title': 'Check Me', 'value': false},
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerCheckboxListTile(
          node, ctx, _childBuilder,
          onChanged: (id, val) => seenId = id,
        )));

    expect(find.text('Check Me'), findsOneWidget);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(seenId, 'cb1');
  });
}
