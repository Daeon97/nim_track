// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/utils/helpers/timestamp_util.dart';

class NodeDataNodeDetailsCard extends StatelessWidget {
  const NodeDataNodeDetailsCard({
    required this.nodeName,
    required this.lastTransmissionDate,
    required this.healthy,
    super.key,
  });

  final String nodeName;
  final int lastTransmissionDate;
  final bool healthy;

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(
          spacing,
        ),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsetsDirectional.all(
            smallSpacing,
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Icon(
                  Icons.developer_board,
                  size: spacing + smallSpacing,
                  color: healthy ? nodeAvailableColor : nodeProblemsColor,
                ),
                const SizedBox(
                  width: smallSpacing,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nodeName,
                        maxLines: veryTinySpacing.toInt(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                      ),
                      Text(
                        TimestampUtil.computeDate(
                          lastTransmissionDate,
                        ),
                        maxLines: veryTinySpacing.toInt(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.merge(
                              TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nodeName,
                        maxLines: veryTinySpacing.toInt(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                      ),
                      Text(
                        TimestampUtil.computeDate(
                          lastTransmissionDate,
                        ),
                        maxLines: veryTinySpacing.toInt(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.merge(
                              TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nodeName,
                        maxLines: veryTinySpacing.toInt(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                      ),
                      Text(
                        TimestampUtil.computeDate(
                          lastTransmissionDate,
                        ),
                        maxLines: veryTinySpacing.toInt(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.merge(
                              TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: smallSpacing,
                ),
                Icon(
                  Icons.navigate_next,
                  size: spacing + tinySpacing,
                  color: Theme.of(context).dividerColor,
                ),
              ],
            ),
          ),
        ),
      );
}
