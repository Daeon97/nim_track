// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:nim_track/core/resources/strings.dart';
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
  Widget build(BuildContext context) => Scaffold(
        body: MapWidget(
          key: const ValueKey(
            mapboxMapKey,
          ),
          resourceOptions: ResourceOptions(
            accessToken: dotenv.env[mapboxSecretTokenKeyName]!,
          ),
        ),
        // GoogleMap(
        //   initialCameraPosition: CameraPosition(
        //     bearing: 192.8334901395799,
        //     target: LatLng(37.43296265331129, -122.08832357078792),
        //     tilt: 59.440717697143555,
        //     zoom: 19.151926040649414,
        //   ),
        // ),
      );
}
