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
  Widget build(BuildContext context) => Container(
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
            smallSpacing,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              const SizedBox(
                width: smallSpacing,
              ),
              Column(
                children: [
                  Text(
                    headerText,
                    style: Theme.of(context).textTheme.bodyMedium?.merge(
                          TextStyle(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
