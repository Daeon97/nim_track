// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';

class NodeDataTopCardShimmerChild extends StatelessWidget {
  const NodeDataTopCardShimmerChild({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsetsDirectional.all(
          smallSpacing,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.developer_board,
              size: spacing + smallSpacing,
              color: Colors.transparent,
            ),
            const SizedBox(
              width: smallSpacing,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  availableLiteral,
                  maxLines: veryTinySpacing.toInt(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.transparent,
                  ),
                ),
                Text(
                  veryTinySpacing.toInt().toString(),
                  maxLines: veryTinySpacing.toInt(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
