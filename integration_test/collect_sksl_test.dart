import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hello_flutter/main.dart';

void main() {
  // When there is SKSL jank, frames will be missed preventing SkSL from being
  // collected properly.
  //
  // Lower the speed of animations to avoid that - see
  // https://github.com/flutter/flutter/issues/84994/ for more details.
  timeDilation = 40.0;

  testWidgets('Collect sksl', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('open')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('close')));
    await tester.pumpAndSettle();
  });
}
