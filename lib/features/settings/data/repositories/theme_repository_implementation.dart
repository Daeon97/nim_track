// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/features/settings/data/data_sources/theme_local_data_source.dart';
import 'package:nim_track/features/settings/domain/repositories/theme_repository.dart';

class ThemeRepositoryImplementation implements ThemeRepository {
  const ThemeRepositoryImplementation({
    required this.themeLocalDataSource,
  });

  final ThemeLocalDataSource themeLocalDataSource;

  @override
  Color get seedColor => themeLocalDataSource.theme.seedColor;

  @override
  Brightness get brightness => themeLocalDataSource.theme.brightness;

  @override
  ColorScheme get colorScheme => themeLocalDataSource.theme.colorScheme;
}
