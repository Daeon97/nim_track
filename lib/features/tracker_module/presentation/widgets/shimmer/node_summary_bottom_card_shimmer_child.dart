// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';

class NodeSummaryBottomCardShimmerChild extends StatelessWidget {
  const NodeSummaryBottomCardShimmerChild({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsetsDirectional.all(
          smallSpacing,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.battery_2_bar_rounded,
              color: Colors.transparent,
            ),
            const SizedBox(
              width: spacing,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    timestampLiteral,
                    style: TextStyle(
                      color: Colors.transparent,
                    ),
                  ),
                  Text(
                    veryLargeSpacing.toInt().toString() + percentage,
                    style: const TextStyle(
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
