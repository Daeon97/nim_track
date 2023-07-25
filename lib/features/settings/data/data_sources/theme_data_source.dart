// ignore_for_file: public_member_api_docs

import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/features/settings/data/models/theme_model.dart';

abstract interface class ThemeDataSource {
  ThemeModel fromJsonToModel({
    required Map<String, dynamic> json,
  });

  Map<String, dynamic> fromModelToJson({
    required ThemeModel themeModel,
  });
}

class ThemeDataSourceImplementation implements ThemeDataSource {
  @override
  Map<String, dynamic> fromModelToJson({
    required ThemeModel themeModel,
  }) =>
      themeModel.toJson();

  @override
  ThemeModel fromJsonToModel({
    required Map<String, dynamic> json,
  }) =>
      switch (
          json.containsKey(seedColorKey) && json.containsKey(brightnessKey)) {
        true => ThemeModel.fromJson(
            json,
          ),
        false => const ThemeModel(
            seedColor: enums.SeedColor.blue,
            brightness: enums.Brightness.light,
          )
      };
}
