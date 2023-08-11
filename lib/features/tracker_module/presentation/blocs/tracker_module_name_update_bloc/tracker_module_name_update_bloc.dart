// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nim_track/core/errors/failure.dart';
import 'package:nim_track/features/tracker_module/domain/use_cases/tracker_module_use_case.dart';

part 'tracker_module_name_update_event.dart';

part 'tracker_module_name_update_state.dart';

class TrackerModuleNameUpdateBloc
    extends Bloc<TrackerModuleNameUpdateEvent, TrackerModuleNameUpdateState> {
  TrackerModuleNameUpdateBloc({
    required TrackerModuleUseCase trackerModuleUseCase,
  })  : _trackerModuleUseCase = trackerModuleUseCase,
        super(
          const TrackerModuleNameUpdateInitialState(),
        ) {
    on<UpdateTrackerModuleNameEvent>(
      (event, emit) async {
        emit(
          const UpdatingTrackerModuleNameState(),
        );
        final failureOrString =
            await _trackerModuleUseCase.updateTrackerModuleName(
          id: event.id,
          name: event.name,
        );
        failureOrString.fold(
          (failure) => add(
            _FailedToUpdateTrackerModuleNameEvent(
              id: event.id,
              name: event.name,
              failure: failure,
            ),
          ),
          (result) => add(
            _UpdatedTrackerModuleNameEvent(
              result: result,
            ),
          ),
        );
      },
    );

    on<_UpdatedTrackerModuleNameEvent>(
      (event, emit) async {
        emit(
          UpdatedTrackerModuleNameState(
            result: event.result,
          ),
        );
      },
    );

    on<_FailedToUpdateTrackerModuleNameEvent>(
      (event, emit) async {
        emit(
          FailedToUpdateTrackerModuleNameState(
            id: event.id,
            name: event.name,
            failure: event.failure,
          ),
        );
      },
    );
  }

  final TrackerModuleUseCase _trackerModuleUseCase;
}
