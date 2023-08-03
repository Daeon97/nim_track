// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nim_track/core/errors/failure.dart';
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';
import 'package:nim_track/features/tracker_module/domain/use_cases/tracker_module_use_case.dart';

part 'tracker_module_detail_event.dart';

part 'tracker_module_detail_state.dart';

class TrackerModuleDetailBloc
    extends Bloc<TrackerModuleDetailEvent, TrackerModuleDetailState> {
  TrackerModuleDetailBloc({
    required TrackerModuleUseCase trackerModuleUseCase,
  })  : _trackerModuleUseCase = trackerModuleUseCase,
        super(
          const TrackerModuleDetailInitialState(),
        ) {
    on<GetTrackerModuleDetailEvent>(
      (event, emit) async {
        emit(
          const GettingTrackerModuleDetailState(),
        );
        final failureOrTrackerModuleEntity =
            await _trackerModuleUseCase.getTrackerModule(
          id: event.id,
        );
        failureOrTrackerModuleEntity.fold(
          (failure) => add(
            FailedToGetTrackerModuleDetailEvent(
              failure: failure,
            ),
          ),
          (trackerModuleEntity) => add(
            GotTrackerModuleDetailEvent(
              trackerModuleEntity: trackerModuleEntity,
            ),
          ),
        );
      },
    );

    on<GotTrackerModuleDetailEvent>(
      (event, emit) => emit(
        GotTrackerModuleDetailState(
          trackerModuleEntity: event.trackerModuleEntity,
        ),
      ),
    );

    on<FailedToGetTrackerModuleDetailEvent>(
      (event, emit) => FailedToGetTrackerModuleDetailEvent(
        failure: event.failure,
      ),
    );
  }

  final TrackerModuleUseCase _trackerModuleUseCase;
}
