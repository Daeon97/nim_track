// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nim_track/core/errors/failure.dart';
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';
import 'package:nim_track/features/tracker_module/domain/use_cases/tracker_module_use_case.dart';

part 'tracker_modules_event.dart';

part 'tracker_modules_state.dart';

class TrackerModulesBloc
    extends Bloc<TrackerModulesEvent, TrackerModulesState> {
  TrackerModulesBloc({
    required TrackerModuleUseCase trackerModuleUseCase,
  })  : _trackerModuleUseCase = trackerModuleUseCase,
        super(
          const TrackerModulesInitialState(),
        ) {
    on<ListTrackerModulesEvent>(
      (event, emit) async {
        emit(
          const ListingTrackerModulesState(),
        );
        final failureOrTrackerModuleEntities =
            await _trackerModuleUseCase.listTrackerModules();
        failureOrTrackerModuleEntities.fold(
          (failure) => add(
            FailedToListTrackerModulesEvent(
              failure: failure,
            ),
          ),
          (trackerModuleEntities) => add(
            ListedTrackerModulesEvent(
              trackerModuleEntities: trackerModuleEntities,
            ),
          ),
        );
      },
    );

    on<ListedTrackerModulesEvent>(
      (event, emit) => emit(
        ListedTrackerModulesState(
          trackerModuleEntities: event.trackerModuleEntities,
        ),
      ),
    );

    on<FailedToListTrackerModulesEvent>(
      (event, emit) => emit(
        FailedToListTrackerModulesState(
          failure: event.failure,
        ),
      ),
    );
  }

  final TrackerModuleUseCase _trackerModuleUseCase;
}
