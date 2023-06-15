import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/features/tracker_module/presentation/screens/home_screen.dart';

void main() {
  testWidgets(
    '''
      should render a mapbox map widget in the
      widget tree when home screen is launched
    ''',
    (tester) async {
      dotenv.testLoad(
        fileInput: File(
          envFileName,
        ).readAsStringSync(),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(),
        ),
      );
      expect(
        find.byKey(
          const ValueKey(
            mapboxMapKey,
          ),
        ),
        findsOneWidget,
      );
    },
  );
}
