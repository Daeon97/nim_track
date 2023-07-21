// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/numbers.dart';

class NodeDataTopCard extends StatelessWidget {
  const NodeDataTopCard({
    required this.icon,
    required this.iconColor,
    required this.headerText,
    required this.valueText,
    super.key,
  });

  final IconData icon;
  final Color iconColor;
  final String headerText;
  final String valueText;

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(
          spacing,
        ),
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).dividerColor,
            ),
            borderRadius: BorderRadius.circular(
              spacing,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.all(
              smallSpacing,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: spacing + smallSpacing,
                  color: iconColor,
                ),
                const SizedBox(
                  width: smallSpacing,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      headerText,
                      maxLines: veryTinySpacing.toInt(),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.merge(
                            TextStyle(
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                    ),
                    Text(
                      valueText,
                      maxLines: veryTinySpacing.toInt(),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge?.merge(
                            const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
