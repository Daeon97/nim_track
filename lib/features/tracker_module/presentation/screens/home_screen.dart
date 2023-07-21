// ignore_for_file: public_member_api_docs

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:nim_track/amplifyconfiguration.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/dashboard_sheet.dart';
// import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

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
    // _configureAmplify();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              MapWidget(
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
                styleUri: Theme.of(context).brightness == Brightness.light
                    ? MapboxStyles.MAPBOX_STREETS
                    : MapboxStyles.DARK,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.all(
                  spacing,
                ),
                child: IconButton(
                  onPressed: () {},
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

// Future<String?> _roughWork(int id) async {
//   try {
//     final graphQLQueryDocument = '''query GetTrackerModule {
//       getTrackerModule(id: $id) {
//         id
//         name
//         data {
//           battery_level
//         }
//       }
//     }''';
//     final operation = Amplify.API.query(
//       request: GraphQLRequest<String>(
//         document: graphQLQueryDocument,
//       ),
//     );
//     final response = await operation.response;
//     return response.data;
//   } on ApiException catch (e) {
//     safePrint(e.message);
//   }
// }
//
// Future<void> _configureAmplify() async {
//   if (!Amplify.isConfigured) {
//     await Amplify.addPlugin(
//       AmplifyAPI(),
//     );
//   }
//
//   try {
//     await Amplify.configure(amplifyconfig);
//     _test.value = true;
//   } on AmplifyAlreadyConfiguredException catch (e) {
//     safePrint(e.message);
//   }
// }
}
