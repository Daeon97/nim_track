import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nim_track/features/tracker_module/presentation/screens/home_screen.dart';

void main() {
  testWidgets(
    '''
      should render a text widget with a value key 't'
      in the widget tree when home screen is launched
    ''',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(),
        ),
      );
      expect(
        find.byKey(
          const ValueKey<String>('t'),
        ),
        findsOneWidget,
      );
    },
  );
}
