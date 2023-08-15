// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;

final class ThemeEntity {
  const ThemeEntity({
    required this.actualSeedColor,
    required this.fakeSeedColor,
    required this.actualBrightness,
    required this.fakeBrightness,
  });

  final Color actualSeedColor;
  final enums.SeedColor fakeSeedColor;
  final Brightness actualBrightness;
  final enums.Brightness fakeBrightness;
}
