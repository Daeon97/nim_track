// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nim_track/core/errors/failure.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';
import 'package:nim_track/features/tracker_module/domain/use_cases/tracker_module_use_case.dart';

part 'tracker_module_event.dart';

part 'tracker_module_state.dart';

class TrackerModuleBloc extends Bloc<TrackerModuleEvent, TrackerModuleState> {
  TrackerModuleBloc({
    required TrackerModuleUseCase trackerModuleUseCase,
  })  : _trackerModuleUseCase = trackerModuleUseCase,
        super(
          const TrackerModuleInitialState(),
        ) {
    on<GetTrackerModuleEvent>(
      (event, emit) async {
        emit(
          const GettingTrackerModuleState(),
        );
        final failureOrTrackerModuleEntity =
            await _trackerModuleUseCase.getTrackerModule(
          id: event.id,
          fields: event.fields,
        );
        failureOrTrackerModuleEntity.fold(
          (failure) => add(
            _FailedToGetTrackerModuleEvent(
              failure: failure,
            ),
          ),
          (trackerModuleEntity) => add(
            _GotTrackerModuleEvent(
              trackerModuleEntity: trackerModuleEntity,
            ),
          ),
        );
      },
    );

    on<_GotTrackerModuleEvent>(
      (event, emit) => emit(
        GotTrackerModuleState(
          trackerModuleEntity: event.trackerModuleEntity,
        ),
      ),
    );

    on<_FailedToGetTrackerModuleEvent>(
      (event, emit) => emit(
        FailedToGetTrackerModuleState(
          failure: event.failure,
        ),
      ),
    );
  }

  final TrackerModuleUseCase _trackerModuleUseCase;
}
