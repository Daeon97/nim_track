// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nim_track/core/errors/failure.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
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
            await _trackerModuleUseCase.listTrackerModules(
          fields: event.fields,
        );
        failureOrTrackerModuleEntities.fold(
          (failure) => add(
            _FailedToListTrackerModulesDetailEvent(
              failure: failure,
            ),
          ),
          (trackerModuleEntities) => add(
            _ListedTrackerModulesDetailEvent(
              trackerModuleEntities: trackerModuleEntities,
            ),
          ),
        );
      },
    );

    on<_ListedTrackerModulesDetailEvent>(
      (event, emit) => emit(
        ListedTrackerModulesDetailState(
          trackerModuleEntities: event.trackerModuleEntities,
        ),
      ),
    );

    on<_FailedToListTrackerModulesDetailEvent>(
      (event, emit) => emit(
        FailedToListTrackerModulesDetailState(
          failure: event.failure,
        ),
      ),
    );
  }

  final TrackerModuleUseCase _trackerModuleUseCase;
}
