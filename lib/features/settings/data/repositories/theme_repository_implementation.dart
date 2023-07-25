// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nim_track/core/resources/colors.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/features/settings/data/data_sources/theme_data_source.dart';
import 'package:nim_track/features/settings/data/models/theme_model.dart';
import 'package:nim_track/features/settings/domain/entities/theme_entity.dart';
import 'package:nim_track/features/settings/domain/repositories/theme_repository.dart';

class ThemeRepositoryImplementation implements ThemeRepository {
  const ThemeRepositoryImplementation({
    required this.themeDataSource,
  });

  final ThemeDataSource themeDataSource;

  @override
  Map<String, dynamic> fromEntityToJson({
    required ThemeEntity themeEntity,
  }) {
    final fakeSeedColor =
        switch (themeEntity.seedColor) { _ => enums.SeedColor.blue };

    final fakeBrightness = switch (themeEntity.brightness) {
      Brightness.light => enums.Brightness.light,
      Brightness.dark => enums.Brightness.dark
    };

    final themeModel = ThemeModel(
      seedColor: fakeSeedColor,
      brightness: fakeBrightness,
    );

    final themeJson = themeDataSource.fromModelToJson(
      themeModel: themeModel,
    );

    return themeJson;
  }

  @override
  ThemeEntity fromJsonToEntity({
    required Map<String, dynamic> json,
  }) {
    final themeModel = themeDataSource.fromJsonToModel(
      json: json,
    );
    final seedColor = themeModel.seedColor;
    final brightness = themeModel.brightness;

    final (
      actualSeedColor,
      actualBrightness,
    ) = _computeActualSeedColorAndBrightness(
      seedColor: seedColor,
      brightness: brightness,
    );

    return ThemeEntity(
      seedColor: actualSeedColor,
      brightness: actualBrightness,
    );
  }

  @override
  ThemeEntity call({
    required enums.SeedColor seedColor,
    required enums.Brightness brightness,
  }) {
    final (
      actualSeedColor,
      actualBrightness,
    ) = _computeActualSeedColorAndBrightness(
      seedColor: seedColor,
      brightness: brightness,
    );

    return ThemeEntity(
      seedColor: actualSeedColor,
      brightness: actualBrightness,
    );
  }

  (Color, Brightness) _computeActualSeedColorAndBrightness({
    required enums.SeedColor seedColor,
    required enums.Brightness brightness,
  }) {
    final actualSeedColor =
        switch (seedColor) { enums.SeedColor.blue => baseColorBlue };

    final actualBrightness = switch (brightness) {
      enums.Brightness.light => Brightness.light,
      enums.Brightness.dark => Brightness.dark,
    };

    return (
      actualSeedColor,
      actualBrightness,
    );
  }
}
