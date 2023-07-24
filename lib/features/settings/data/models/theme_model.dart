// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';
import 'package:nim_track/features/settings/domain/entities/theme_entity.dart';

part 'theme_model.g.dart';

@JsonSerializable()
final class ThemeModel extends ThemeEntity {
  const ThemeModel({
    required super.seedColor,
    required super.brightness,
    required super.colorScheme,
  });

  factory ThemeModel.fromJson(Map<String, dynamic> json) =>
      _$ThemeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThemeModelToJson(this);
}
