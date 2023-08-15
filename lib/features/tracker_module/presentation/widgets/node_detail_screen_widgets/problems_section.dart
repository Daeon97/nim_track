// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/extensions/tracker_module_related_entities_convenience_utils.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_module_detail_bloc/tracker_module_detail_bloc.dart';

class ProblemsSection extends StatelessWidget {
  const ProblemsSection({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TrackerModuleDetailBloc, TrackerModuleDetailState>(
        builder: (_, trackerModuleDetailState) =>
            switch (trackerModuleDetailState) {
          GotTrackerModuleDetailState(trackerModuleEntity: final entity)
              when entity.potentiallyFaulty =>
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Icon(
                  Icons.warning,
                  color: potentiallyFaultyNodesColor,
                ),
                const SizedBox(
                  width: smallSpacing,
                ),
                Text(
                  noTransmissionWithinlastHourLiteral,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.merge(
                        const TextStyle(
                          color: potentiallyFaultyNodesColor,
                        ),
                      ),
                ),
              ],
            ),
          _ => const SizedBox.shrink()
        },
      );
}
