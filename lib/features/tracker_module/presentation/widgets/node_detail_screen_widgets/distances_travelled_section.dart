// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/extensions/tracker_module_data_entities_convenience_utils.dart';
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';
import 'package:nim_track/features/tracker_module/presentation/blocs/tracker_modules_detail_bloc/tracker_modules_detail_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DistancesTravelledSection extends StatelessWidget {
  const DistancesTravelledSection({
    required this.id,
    super.key,
  });

  final int id;

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsetsDirectional.all(
          spacing,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).textTheme.bodyMedium!.color!,
          ),
          borderRadius: BorderRadius.circular(
            spacing,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsetsDirectional.all(
                    smallSpacing,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.moving,
                  ),
                ),
                const SizedBox(
                  width: spacing,
                ),
                Expanded(
                  child: Text(
                    distancesTravelledLiteral,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: distancesTravelledSectionHeight,
              child: BlocBuilder<TrackerModulesDetailBloc,
                  TrackerModulesDetailState>(
                builder: (_, trackerModulesDetailState) =>
                    switch (trackerModulesDetailState) {
                  ListingTrackerModulesDetailState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ListedTrackerModulesDetailState(
                    trackerModuleEntities: final entities,
                  ) =>
                    SfCircularChart(
                      margin: EdgeInsets.zero,
                      tooltipBehavior: TooltipBehavior(
                        activationMode: ActivationMode.singleTap,
                        enable: true,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        elevation: smallSpacing,
                        textStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                      legend: const Legend(
                        isVisible: true,
                        position: LegendPosition.bottom,
                      ),
                      series: <DoughnutSeries<TrackerModuleEntity, String>>[
                        DoughnutSeries<TrackerModuleEntity, String>(
                          explode: true,
                          explodeIndex: entities.indexWhere(
                            (trackerModuleEntity) =>
                                trackerModuleEntity.id == id,
                          ),
                          explodeOffset: distancesTravelledSectionExplodeOffset,
                          dataSource: entities,
                          xValueMapper: (trackerModuleEntity, _) =>
                              trackerModuleEntity.name ??
                              '$nodeLiteral ${trackerModuleEntity.id}',
                          yValueMapper: (trackerModuleEntity, _) =>
                              trackerModuleEntity.data.totalDistanceKilometer,
                          dataLabelMapper: (trackerModuleEntity, _) =>
                              '${trackerModuleEntity.name ?? '$nodeLiteral ${trackerModuleEntity.id}'}$colon$newLine${trackerModuleEntity.data.totalDistanceKilometer}$kmLiteral',
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                          ),
                        ),
                      ],
                    ),
                  _ => const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            size: largeSpacing + spacing,
                          ),
                          SizedBox(
                            height: smallSpacing,
                          ),
                          Text(
                            errorDisplayingDataLiteral,
                          ),
                        ],
                      ),
                    ),
                },
              ),
            ),
          ],
        ),
      );
}
