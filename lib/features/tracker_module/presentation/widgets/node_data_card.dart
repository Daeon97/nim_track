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
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
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
            ],
          ),
          const SizedBox(
            height: spacing,
          ),
          ...List<Widget>.generate(
            (veryTinySpacing + tinySpacing + tinySpacing).toInt(),
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
      );
}
