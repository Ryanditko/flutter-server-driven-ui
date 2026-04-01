import 'package:flutter/material.dart';
import 'package:flutter_backend_driven_ui/core/utils/parsing_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('parsePadding', () {
    test('null returns null', () {
      expect(parsePadding(null), isNull);
    });

    test('num returns EdgeInsets.all', () {
      expect(parsePadding(16), const EdgeInsets.all(16));
    });

    test('map returns LTRB', () {
      expect(
        parsePadding({'left': 1, 'top': 2, 'right': 3, 'bottom': 4}),
        const EdgeInsets.fromLTRB(1, 2, 3, 4),
      );
    });
  });

  group('parseAlignment', () {
    test('known values', () {
      expect(parseAlignment('topLeft'), Alignment.topLeft);
      expect(parseAlignment('center'), Alignment.center);
      expect(parseAlignment('bottomRight'), Alignment.bottomRight);
    });

    test('unknown defaults to topStart', () {
      expect(parseAlignment('unknown'), AlignmentDirectional.topStart);
    });

    test('null defaults to topStart', () {
      expect(parseAlignment(null), AlignmentDirectional.topStart);
    });
  });

  group('parseMainAxisAlignment', () {
    test('known values', () {
      expect(parseMainAxisAlignment('center'), MainAxisAlignment.center);
      expect(parseMainAxisAlignment('spaceBetween'), MainAxisAlignment.spaceBetween);
    });

    test('null defaults to start', () {
      expect(parseMainAxisAlignment(null), MainAxisAlignment.start);
    });
  });

  group('parseCrossAxisAlignment', () {
    test('known values', () {
      expect(parseCrossAxisAlignment('stretch'), CrossAxisAlignment.stretch);
      expect(parseCrossAxisAlignment('end'), CrossAxisAlignment.end);
    });

    test('null defaults to start', () {
      expect(parseCrossAxisAlignment(null), CrossAxisAlignment.start);
    });
  });

  group('parseAxis', () {
    test('horizontal', () => expect(parseAxis('horizontal'), Axis.horizontal));
    test('vertical', () => expect(parseAxis('vertical'), Axis.vertical));
    test('null defaults to vertical', () => expect(parseAxis(null), Axis.vertical));
  });

  group('parseTextAlign', () {
    test('center', () => expect(parseTextAlign('center'), TextAlign.center));
    test('null returns null', () => expect(parseTextAlign(null), isNull));
  });

  group('parseFontWeight', () {
    test('bold', () => expect(parseFontWeight('bold'), FontWeight.w700));
    test('w400', () => expect(parseFontWeight('w400'), FontWeight.w400));
    test('null returns null', () => expect(parseFontWeight(null), isNull));
  });

  group('parseFontStyle', () {
    test('italic', () => expect(parseFontStyle('italic'), FontStyle.italic));
    test('null returns null', () => expect(parseFontStyle(null), isNull));
  });

  group('parseTextDecoration', () {
    test('underline', () => expect(parseTextDecoration('underline'), TextDecoration.underline));
    test('null returns null', () => expect(parseTextDecoration(null), isNull));
  });

  group('parseTextOverflow', () {
    test('ellipsis', () => expect(parseTextOverflow('ellipsis'), TextOverflow.ellipsis));
    test('null returns null', () => expect(parseTextOverflow(null), isNull));
  });

  group('parseBoxFit', () {
    test('cover', () => expect(parseBoxFit('cover'), BoxFit.cover));
    test('null defaults to contain', () => expect(parseBoxFit(null), BoxFit.contain));
  });

  group('parseStackFit', () {
    test('expand', () => expect(parseStackFit('expand'), StackFit.expand));
    test('null defaults to loose', () => expect(parseStackFit(null), StackFit.loose));
  });

  group('parseClipBehavior', () {
    test('antiAlias', () => expect(parseClipBehavior('antiAlias'), Clip.antiAlias));
    test('null defaults to hardEdge', () => expect(parseClipBehavior(null), Clip.hardEdge));
  });

  group('parseBorderRadius', () {
    test('null returns null', () => expect(parseBorderRadius(null), isNull));
    test('num returns circular', () {
      expect(parseBorderRadius(8), BorderRadius.circular(8));
    });
    test('map returns per-corner', () {
      final result = parseBorderRadius({'topLeft': 4, 'bottomRight': 8});
      expect(result, isNotNull);
    });
  });

  group('parseBoxConstraints', () {
    test('null returns null', () => expect(parseBoxConstraints(null), isNull));
    test('parses min/max values', () {
      final bc = parseBoxConstraints({'minWidth': 50, 'maxWidth': 200});
      expect(bc!.minWidth, 50);
      expect(bc.maxWidth, 200);
    });
  });

  group('parseBoxDecoration', () {
    test('null returns empty BoxDecoration', () {
      expect(parseBoxDecoration(null), const BoxDecoration());
    });
    test('parses color', () {
      final dec = parseBoxDecoration({'color': '#FF0000'});
      expect(dec.color, isNotNull);
    });
  });

  group('parseDuration', () {
    test('num returns Duration', () {
      expect(parseDuration(500), const Duration(milliseconds: 500));
    });
    test('non-num returns fallback', () {
      expect(parseDuration('bad'), const Duration(milliseconds: 300));
    });
  });

  group('parseCurve', () {
    test('linear', () => expect(parseCurve('linear'), Curves.linear));
    test('bounceOut', () => expect(parseCurve('bounceOut'), Curves.bounceOut));
    test('null defaults to easeInOut', () => expect(parseCurve(null), Curves.easeInOut));
  });

  group('parseScrollPhysics', () {
    test('bouncing', () => expect(parseScrollPhysics('bouncing'), isA<BouncingScrollPhysics>()));
    test('null returns null', () => expect(parseScrollPhysics(null), isNull));
  });

  group('parseVerticalDirection', () {
    test('up', () => expect(parseVerticalDirection('up'), VerticalDirection.up));
    test('null defaults to down', () => expect(parseVerticalDirection(null), VerticalDirection.down));
  });

  group('parseTextDirection', () {
    test('rtl', () => expect(parseTextDirection('rtl'), TextDirection.rtl));
    test('null returns null', () => expect(parseTextDirection(null), isNull));
  });
}
