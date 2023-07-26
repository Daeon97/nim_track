// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeModel _$ThemeModelFromJson(Map<String, dynamic> json) => ThemeModel(
      fakeSeedColor: $enumDecode(_$SeedColorEnumMap, json['fake_seed_color']),
      fakeBrightness: $enumDecode(_$BrightnessEnumMap, json['fake_brightness']),
    );

Map<String, dynamic> _$ThemeModelToJson(ThemeModel instance) =>
    <String, dynamic>{
      'fake_seed_color': _$SeedColorEnumMap[instance.fakeSeedColor]!,
      'fake_brightness': _$BrightnessEnumMap[instance.fakeBrightness]!,
    };

const _$SeedColorEnumMap = {
  SeedColor.blue: 'blue',
  SeedColor.yellow: 'yellow',
  SeedColor.purple: 'purple',
  SeedColor.orange: 'orange',
};

const _$BrightnessEnumMap = {
  Brightness.light: 'light',
  Brightness.dark: 'dark',
};
