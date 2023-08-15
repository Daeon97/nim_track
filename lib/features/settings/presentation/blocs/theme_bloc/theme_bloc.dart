// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/features/settings/domain/entities/theme_entity.dart';
import 'package:nim_track/features/settings/domain/use_cases/theme_use_case.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc({
    required ThemeUseCase themeUseCase,
  })  : _themeUseCase = themeUseCase,
        super(
          ThemeState(
            themeEntity: themeUseCase(
              fakeSeedColor: enums.SeedColor.blue,
              fakeBrightness: enums.Brightness.light,
            ),
          ),
        ) {
    on<ThemeEvent>(
      (event, emit) {
        final themeEntity = _themeUseCase(
          fakeSeedColor: event.fakeSeedColor,
          fakeBrightness: event.fakeBrightness,
        );

        emit(
          ThemeState(
            themeEntity: themeEntity,
          ),
        );
      },
    );
  }

  final ThemeUseCase _themeUseCase;

  @override
  ThemeState? fromJson(
    Map<String, dynamic> json,
  ) =>
      ThemeState(
        themeEntity: _themeUseCase.fromJsonToEntity(
          json: json,
        ),
      );

  @override
  Map<String, dynamic>? toJson(
    ThemeState state,
  ) =>
      _themeUseCase.fromEntityToJson(
        themeEntity: state.themeEntity,
      );
}
