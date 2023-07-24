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
          Row(
            children: [
              Expanded(
                flex: tinySpacing.toInt(),
                child: Container(
                  height: extraLargeSpacing -
                      (veryTinySpacing + tinySpacing + tinySpacing),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(
                      spacing,
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_left)),
                      Expanded(
                        child: RotatedBox(
                          quarterTurns: -veryTinySpacing.toInt(),
                          child: ListWheelScrollView(
                            // physics: NeverScrollableScrollPhysics(),
                            itemExtent: largeSpacing + spacing,
                            diameterRatio: veryTinySpacing,
                            offAxisFraction: veryTinySpacing,
                            clipBehavior: Clip.antiAlias,
                            children: List<Widget>.generate(
                              veryTinySpacing.toInt() + smallSpacing.toInt(),
                              (index) => RotatedBox(
                                quarterTurns: veryTinySpacing.toInt(),
                                child: // TextButton(
                                    // style: ButtonStyle(
                                    //   backgroundColor: MaterialStatePropertyAll<Color>(
                                    //     Theme.of(context).textTheme.bodyMedium!.color!,
                                    //   ),
                                    // ),
                                    // onPressed: () {},
                                    // child:
                                    Text(
                                  index == nil.toInt()
                                      ? allLiteral
                                      : index.toString(),
                                  // style: Theme.of(context)
                                  //     .textTheme
                                  //     .bodyMedium
                                  //     ?.merge(
                                  //       TextStyle(
                                  //         color: Theme.of(context).primaryColorDark,
                                  //       ),
                                  //     ),
                                ),
                                // ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_right)),
                    ],
                  ),
                ),
              ),
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
            ],
          ),
          const SizedBox(
            height: spacing,
          ),
          Row(
            children: [
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
              Expanded(
                flex: tinySpacing.toInt(),
                child: Container(
                  height: extraLargeSpacing -
                      (veryTinySpacing + tinySpacing + tinySpacing),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(
                      spacing,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
