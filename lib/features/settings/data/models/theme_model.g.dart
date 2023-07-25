// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeModel _$ThemeModelFromJson(Map<String, dynamic> json) => ThemeModel(
      seedColor: $enumDecode(_$SeedColorEnumMap, json['seed_color']),
      brightness: $enumDecode(_$BrightnessEnumMap, json['brightness']),
    );

Map<String, dynamic> _$ThemeModelToJson(ThemeModel instance) =>
    <String, dynamic>{
      'seed_color': _$SeedColorEnumMap[instance.seedColor]!,
      'brightness': _$BrightnessEnumMap[instance.brightness]!,
    };

const _$SeedColorEnumMap = {
  SeedColor.blue: 'blue',
};

const _$BrightnessEnumMap = {
  Brightness.light: 'light',
  Brightness.dark: 'dark',
};
