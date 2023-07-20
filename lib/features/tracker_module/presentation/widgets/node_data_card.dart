// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/features/tracker_module/presentation/widgets/node_data_top_card.dart';

class NodeDataCard extends StatelessWidget {
  const NodeDataCard({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).iconTheme.color!,
          ),
          borderRadius: BorderRadius.circular(
            spacing,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.all(
            spacing,
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
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
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: NodeDataTopCard(
                      icon: Icons.developer_board,
                      iconColor: nodeAvailableColor,
                      headerText: availableLiteral,
                      valueText: availableLiteral,
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
                      valueText: problemsLiteral,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
