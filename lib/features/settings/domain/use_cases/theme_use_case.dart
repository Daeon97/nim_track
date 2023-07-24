// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/features/settings/domain/repositories/theme_repository.dart';

class ThemeUseCase {
  const ThemeUseCase({
    required this.themeRepository,
  });

  final ThemeRepository themeRepository;

  Color get seedColor => themeRepository.seedColor;

  Brightness get brightness => themeRepository.brightness;

  ColorScheme get colorScheme => themeRepository.colorScheme;
}
