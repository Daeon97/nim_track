// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_data_node_details_card.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_data_top_card.dart';

class NodeDataCard extends StatelessWidget {
  const NodeDataCard({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
          borderRadius: BorderRadius.circular(
            spacing,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: spacing,
          ),
          child: Column(
            children: [
              const Icon(
                Icons.data_exploration,
              ),
              const SizedBox(
                height: smallSpacing,
              ),
              Text(
                nodeDataLiteral,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Divider(
                indent: spacing,
                endIndent: spacing,
              ),
              const SizedBox(
                height: smallSpacing,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: spacing,
                  ),
                  Expanded(
                    child: NodeDataTopCard(
                      icon: Icons.developer_board,
                      iconColor: nodeAvailableColor,
                      headerText: availableLiteral,
                      valueText: smallSpacing.toInt().toString(),
                    ),
                  ),
                  const SizedBox(
                    width: spacing,
                  ),
                  Expanded(
                    child: NodeDataTopCard(
                      icon: Icons.developer_board_off,
                      iconColor: nodeProblemsColor,
                      headerText: problemsLiteral,
                      valueText: veryTinySpacing.toInt().toString(),
                    ),
                  ),
                  const SizedBox(
                    width: spacing,
                  ),
                ],
              ),
              const SizedBox(
                height: spacing,
              ),
              ...List<Widget>.generate(
                (veryTinySpacing + tinySpacing).toInt(),
                (index) => NodeDataNodeDetailsCard(
                  nodeName: switch (index) {
                    nil => placeholderId1.toString(),
                    veryTinySpacing => placeholderName2,
                    tinySpacing => placeholderId3.toString(),
                    const (veryTinySpacing + tinySpacing) =>
                      placeholderId4.toString(),
                    const (tinySpacing + tinySpacing) => placeholderName5,
                    const (veryTinySpacing + tinySpacing + tinySpacing) =>
                      placeholderId6.toString(),
                    const (tinySpacing + tinySpacing + tinySpacing) =>
                      placeholderId7.toString(),
                    _ => placeholderName8
                  },
                  lastTransmissionDate: placeholderTimestamp,
                  healthy: index != tinySpacing,
                ),
                growable: false,
              ),
              const SizedBox(
                height: spacing,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: spacing,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    viewAllLiteral,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
