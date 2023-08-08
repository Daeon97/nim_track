// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nim_track/core/errors/failure.dart';
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';
import 'package:nim_track/features/tracker_module/domain/use_cases/tracker_module_use_case.dart';

part 'tracker_modules_detail_event.dart';

part 'tracker_modules_detail_state.dart';

class TrackerModulesDetailBloc
    extends Bloc<TrackerModulesDetailEvent, TrackerModulesDetailState> {
  TrackerModulesDetailBloc({
    required TrackerModuleUseCase trackerModuleUseCase,
  })  : _trackerModuleUseCase = trackerModuleUseCase,
        super(
          const TrackerModulesDetailInitialState(),
        ) {
    on<ListTrackerModulesDetailEvent>(
      (event, emit) async {
        emit(
          const ListingTrackerModulesDetailState(),
        );
        final failureOrTrackerModuleEntities =
            await _trackerModuleUseCase.listTrackerModules();
        failureOrTrackerModuleEntities.fold(
          (failure) => add(
            FailedToListTrackerModulesDetailEvent(
              failure: failure,
            ),
          ),
          (trackerModuleEntities) => add(
            ListedTrackerModulesDetailEvent(
              trackerModuleEntities: trackerModuleEntities,
            ),
          ),
        );
      },
    );

    on<ListedTrackerModulesDetailEvent>(
      (event, emit) => emit(
        ListedTrackerModulesDetailState(
          trackerModuleEntities: event.trackerModuleEntities,
        ),
      ),
    );

    on<FailedToListTrackerModulesDetailEvent>(
      (event, emit) => emit(
        FailedToListTrackerModulesDetailState(
          failure: event.failure,
        ),
      ),
    );
  }

  final TrackerModuleUseCase _trackerModuleUseCase;
}
