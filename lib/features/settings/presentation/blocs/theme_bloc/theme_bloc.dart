// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nim_track/features/settings/domain/use_cases/theme_use_case.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc({
    required this.themeUseCase,
  }) : super(
          const ThemeState(),
        ) {
    on<ThemeEvent>(
      (event, emit) {
        // TODO: implement event handler
      },
    );
  }

  final ThemeUseCase themeUseCase;

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
