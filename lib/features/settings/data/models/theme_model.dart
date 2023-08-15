// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';
import 'package:nim_track/core/resources/strings.dart';
import 'package:nim_track/core/utils/enums.dart';

part 'theme_model.g.dart';

@JsonSerializable()
final class ThemeModel {
  const ThemeModel({
    required this.fakeSeedColor,
    required this.fakeBrightness,
  });

  factory ThemeModel.fromJson(Map<String, dynamic> json) =>
      _$ThemeModelFromJson(json);

  @JsonKey(name: fakeSeedColorKey)
  final SeedColor fakeSeedColor;

  @JsonKey(name: fakeBrightnessKey)
  final Brightness fakeBrightness;

  Map<String, dynamic> toJson() => _$ThemeModelToJson(this);
}
