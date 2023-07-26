// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/features/settings/domain/entities/theme_entity.dart';

abstract interface class ThemeRepository {
  ThemeEntity fromJsonToEntity({
    required Map<String, dynamic> json,
  });

  Map<String, dynamic> fromEntityToJson({
    required ThemeEntity themeEntity,
  });

  ThemeEntity call({
    required enums.SeedColor fakeSeedColor,
    required enums.Brightness fakeBrightness,
  });
}
