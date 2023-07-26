// ignore_for_file: public_member_api_docs

import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/features/settings/domain/entities/theme_entity.dart';
import 'package:nim_track/features/settings/domain/repositories/theme_repository.dart';

class ThemeUseCase {
  const ThemeUseCase({
    required this.themeRepository,
  });

  final ThemeRepository themeRepository;

  ThemeEntity fromJsonToEntity({
    required Map<String, dynamic> json,
  }) =>
      themeRepository.fromJsonToEntity(
        json: json,
      );

  Map<String, dynamic> fromEntityToJson({
    required ThemeEntity themeEntity,
  }) =>
      themeRepository.fromEntityToJson(
        themeEntity: themeEntity,
      );

  ThemeEntity call({
    required enums.SeedColor fakeSeedColor,
    required enums.Brightness fakeBrightness,
  }) =>
      themeRepository(
        fakeSeedColor: fakeSeedColor,
        fakeBrightness: fakeBrightness,
      );
}
