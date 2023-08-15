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
    required ThemeDataSource themeDataSource,
  }) : _themeDataSource = themeDataSource;

  final ThemeDataSource _themeDataSource;

  @override
  Map<String, dynamic> fromEntityToJson({
    required ThemeEntity themeEntity,
  }) {
    final themeModel = ThemeModel(
      fakeSeedColor: themeEntity.fakeSeedColor,
      fakeBrightness: themeEntity.fakeBrightness,
    );

    final themeJson = _themeDataSource.fromModelToJson(
      themeModel: themeModel,
    );

    return themeJson;
  }

  @override
  ThemeEntity fromJsonToEntity({
    required Map<String, dynamic> json,
  }) {
    final themeModel = _themeDataSource.fromJsonToModel(
      json: json,
    );
    final fakeSeedColor = themeModel.fakeSeedColor;
    final fakeBrightness = themeModel.fakeBrightness;

    final (
      actualSeedColor,
      actualBrightness,
    ) = _computeActualSeedColorAndBrightness(
      fakeSeedColor: fakeSeedColor,
      fakeBrightness: fakeBrightness,
    );

    return ThemeEntity(
      actualSeedColor: actualSeedColor,
      fakeSeedColor: fakeSeedColor,
      actualBrightness: actualBrightness,
      fakeBrightness: fakeBrightness,
    );
  }

  @override
  ThemeEntity call({
    required enums.SeedColor fakeSeedColor,
    required enums.Brightness fakeBrightness,
  }) {
    final (
      actualSeedColor,
      actualBrightness,
    ) = _computeActualSeedColorAndBrightness(
      fakeSeedColor: fakeSeedColor,
      fakeBrightness: fakeBrightness,
    );

    return ThemeEntity(
      actualSeedColor: actualSeedColor,
      fakeSeedColor: fakeSeedColor,
      actualBrightness: actualBrightness,
      fakeBrightness: fakeBrightness,
    );
  }

  (Color, Brightness) _computeActualSeedColorAndBrightness({
    required enums.SeedColor fakeSeedColor,
    required enums.Brightness fakeBrightness,
  }) {
    final actualSeedColor = switch (fakeSeedColor) {
      enums.SeedColor.blue => baseColorBlue,
      enums.SeedColor.yellow => baseColorYellow,
      enums.SeedColor.purple => baseColorPurple,
      enums.SeedColor.orange => baseColorOrange
    };

    final actualBrightness = switch (fakeBrightness) {
      enums.Brightness.light => Brightness.light,
      enums.Brightness.dark => Brightness.dark
    };

    return (actualSeedColor, actualBrightness);
  }
}
