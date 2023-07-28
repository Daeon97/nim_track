// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/features/settings/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_modules_bloc/tracker_modules_bloc.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/dashboard_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<TrackerModulesBloc>(context).add(
      const ListTrackerModulesEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (_, themeState) => MapWidget(
                  cameraOptions: CameraOptions(
                    center: Point(
                      coordinates: Position(
                        defaultLng,
                        defaultLat,
                      ),
                    ).toJson(),
                    zoom: defaultZoom,
                  ),
                  key: const ValueKey(
                    mapboxMapKey,
                  ),
                  resourceOptions: ResourceOptions(
                    accessToken: dotenv.env[mapboxSecretTokenKeyName]!,
                  ),
                  styleUri: themeState.themeEntity.fakeBrightness ==
                          enums.Brightness.light
                      ? MapboxStyles.MAPBOX_STREETS
                      : MapboxStyles.DARK,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.all(
                  spacing,
                ),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pushNamed(
                    settingsScreenRoute,
                  ),
                  icon: const Icon(
                    Icons.settings,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: const DashboardSheet(),
      );
}
