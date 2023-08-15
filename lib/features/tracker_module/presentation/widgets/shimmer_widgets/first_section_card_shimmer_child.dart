// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/numbers.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart';

class FirstSectionCardShimmerChild extends StatelessWidget {
  const FirstSectionCardShimmerChild({
    this.cardType,
    super.key,
  });

  final CardType? cardType;

  @override
  Widget build(BuildContext context) => Text(
        switch (cardType) {
          null => '${tinySpacing.toInt()}$colon$thirtyPercent $pmLiteral',
          CardType.batteryLevel => '$twentyPercent$percentage',
          CardType.time =>
            '${tinySpacing.toInt()}$colon$thirtyPercent $pmLiteral'
        },
        maxLines: veryTinySpacing.toInt(),
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.headlineSmall?.merge(
              const TextStyle(
                color: Colors.transparent,
              ),
            ),
      );
}
