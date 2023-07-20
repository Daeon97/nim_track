// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/features/tracker_module/presentation/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: baseColor,
            brightness: Brightness.dark,
          ),
        ),
        onGenerateRoute: _routes,
      );

  Route<String> _routes(RouteSettings settings) => MaterialPageRoute(
        builder: (_) {
          switch (settings.name) {
            case defaultScreenRoute:
            case homeScreenRoute:
            default:
              return const HomeScreen();
          }
        },
      );
}
