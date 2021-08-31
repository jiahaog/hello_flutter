import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:hello_flutter/main.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  // This needs to be set so frames don't have to be pumped. Not completely sure
  // why [pumpAndSettle] doesn't work for the collected SkSL.
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.benchmarkLive;

  // When there is SKSL jank, frames will be missed preventing SkSL from being
  // collected properly.
  //
  // Lower the speed of animations to avoid that - see
  // https://github.com/flutter/flutter/issues/84994/ for more details.
  timeDilation = 3.0;

  testWidgets('Collect sksl', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await Future.delayed(Duration(seconds: 3));

    await tester.tap(find.byKey(Key('open')));
    await Future.delayed(Duration(seconds: 3));

    await tester.tap(find.byKey(Key('close')));
    await Future.delayed(Duration(seconds: 3));
  });
}
