// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_bloc/tracker_module_bloc.dart';

class NodeDetailScreen extends StatefulWidget {
  const NodeDetailScreen({
    required this.id,
    super.key,
  });

  final int id;

  @override
  State<NodeDetailScreen> createState() => _NodeDetailScreenState();
}

class _NodeDetailScreenState extends State<NodeDetailScreen> {
  @override
  void initState() {
    // BlocProvider.of<TrackerModuleBloc>(context).add(
    //   GetTrackerModuleEvent(
    //     id: widget.id,
    //   ),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.vertical(
              bottom: Radius.circular(
                spacing,
              ),
            ),
          ),
        ),
        body: Column(
          children: [],
        ),
      );
}
