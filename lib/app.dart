// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/features/settings/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:nim_track/features/settings/presentation/screens/settings_screen.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_bloc/tracker_module_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_modules_bloc/tracker_modules_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/screens/all_nodes_screen.dart';
import 'package:nim_track/features/tracker_module/presentation/screens/home_screen.dart';
import 'package:nim_track/features/tracker_module/presentation/screens/node_detail_screen.dart';
import 'package:nim_track/injection_container.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: _providers,
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (_, themeState) => MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: themeState.themeEntity.actualSeedColor,
                brightness: themeState.themeEntity.actualBrightness,
              ),
            ),
            onGenerateRoute: _routes,
          ),
        ),
      );

  List<BlocProvider> get _providers => [
        BlocProvider<TrackerModuleBloc>(
          create: (_) => sl(),
        ),
        BlocProvider<TrackerModulesBloc>(
          create: (_) => sl(),
        ),
        BlocProvider<ThemeBloc>(
          create: (_) => sl(),
        ),
      ];

  Route<String> _routes(RouteSettings settings) => MaterialPageRoute(
        builder: (_) => switch (settings.name) {
          settingsScreenRoute => const SettingsScreen(),
          nodeDetailScreenRoute => const NodeDetailScreen(),
          allNodesScreenRoute => const AllNodesScreen(),
          _ => const HomeScreen()
        },
      );
}
