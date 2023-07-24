// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

base class ThemeEntity {
  const ThemeEntity({
    required this.seedColor,
    required this.brightness,
    required this.colorScheme,
  });

  final Color seedColor;
  final Brightness brightness;
  final ColorScheme colorScheme;
}
