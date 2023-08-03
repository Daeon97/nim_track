// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/numbers.dart';

class NodeDistancesSection extends StatelessWidget {
  const NodeDistancesSection({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsetsDirectional.all(
          spacing,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).textTheme.bodyMedium!.color!,
          ),
          borderRadius: BorderRadius.circular(
            spacing,
          ),
        ),
      );
}
