// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_data_top_card.dart';

class NodeSummaryCard extends StatelessWidget {
  const NodeSummaryCard({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ListWheelScrollView(
            itemExtent: largeSpacing,
            children: List<Widget>.generate(
              smallSpacing.toInt(),
              (index) => Text(
                (index + veryTinySpacing.toInt()).toString(),
              ),
            ),
          ),
          const SizedBox(
            height: spacing,
          ),
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
        ],
      );
}
