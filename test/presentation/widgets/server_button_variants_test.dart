import 'package:flutter/material.dart';
import 'package:flutter_backend_driven_ui/core/models/screen_contract.dart';
import 'package:flutter_backend_driven_ui/presentation/widgets/server_button_variants.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget Function(BuildContext) builder) {
  return MaterialApp(
    home: Scaffold(body: Builder(builder: builder)),
  );
}

Widget _childBuilder(ComponentNode c) => const SizedBox();

void main() {
  testWidgets('buildServerTextButton renders label', (tester) async {
    final node = ComponentNode(
      type: 'textButton',
      props: const {'label': 'Click Me'},
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerTextButton(node, ctx, _childBuilder)));

    expect(find.text('Click Me'), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });

  testWidgets('buildServerOutlinedButton renders label', (tester) async {
    final node = ComponentNode(
      type: 'outlinedButton',
      props: const {'label': 'Outline'},
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerOutlinedButton(node, ctx, _childBuilder)));

    expect(find.text('Outline'), findsOneWidget);
    expect(find.byType(OutlinedButton), findsOneWidget);
  });

  testWidgets('buildServerIconButton renders icon', (tester) async {
    final node = ComponentNode(
      type: 'iconButton',
      props: const {'icon': 'home', 'tooltip': 'Home'},
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerIconButton(node, ctx, _childBuilder)));

    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
  });

  testWidgets('buildServerFab renders FloatingActionButton', (tester) async {
    final node = ComponentNode(
      type: 'floatingActionButton',
      props: const {'icon': 'add'},
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerFab(node, ctx, _childBuilder)));

    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('buildServerFab extended renders label and icon', (tester) async {
    final node = ComponentNode(
      type: 'floatingActionButton',
      props: const {'icon': 'add', 'label': 'New Item'},
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerFab(node, ctx, _childBuilder)));

    expect(find.text('New Item'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('textButton has Semantics wrapper', (tester) async {
    final node = ComponentNode(
      type: 'textButton',
      props: const {'label': 'Accessible'},
    );

    await tester.pumpWidget(_wrap((ctx) => buildServerTextButton(node, ctx, _childBuilder)));

    expect(find.byType(Semantics), findsWidgets);
  });
}
