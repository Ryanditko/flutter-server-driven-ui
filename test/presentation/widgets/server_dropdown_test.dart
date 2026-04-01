import 'package:flutter/material.dart';
import 'package:flutter_backend_driven_ui/core/models/screen_contract.dart';
import 'package:flutter_backend_driven_ui/presentation/widgets/server_dropdown.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget Function(BuildContext) builder) {
  return MaterialApp(
    home: Scaffold(body: Builder(builder: builder)),
  );
}

Widget _childBuilder(ComponentNode c) => const SizedBox.shrink();

void main() {
  testWidgets('dropdown renders with label and hint', (tester) async {
    final node = ComponentNode(
      type: 'dropdown',
      id: 'country',
      props: const {
        'label': 'Country',
        'hint': 'Choose one',
        'options': [
          {'value': 'br', 'label': 'Brazil'},
          {'value': 'us', 'label': 'United States'},
        ],
      },
    );

    await tester.pumpWidget(
      _wrap((ctx) => buildServerDropdown(node, ctx, _childBuilder)),
    );

    expect(find.text('Country'), findsOneWidget);
    expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
  });

  testWidgets('dropdown calls onChanged when selection changes', (tester) async {
    String? seenId;
    String? seenValue;

    final node = ComponentNode(
      type: 'dropdown',
      id: 'lang',
      props: const {
        'label': 'Language',
        'options': [
          {'value': 'en', 'label': 'English'},
          {'value': 'pt', 'label': 'Portuguese'},
        ],
      },
    );

    await tester.pumpWidget(
      _wrap((ctx) => buildServerDropdown(
            node, ctx, _childBuilder,
            onChanged: (id, val) {
              seenId = id;
              seenValue = val;
            },
          )),
    );

    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Portuguese').last);
    await tester.pumpAndSettle();

    expect(seenId, 'lang');
    expect(seenValue, 'pt');
  });
}
