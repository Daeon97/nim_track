// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: Text(
            'NimTrack',
            key: ValueKey<String>('t'),
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
