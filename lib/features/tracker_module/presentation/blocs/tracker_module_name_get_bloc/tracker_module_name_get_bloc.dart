// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nim_track/core/errors/failure.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/features/tracker_module/domain/use_cases/tracker_module_use_case.dart';

part 'tracker_module_name_get_event.dart';

part 'tracker_module_name_get_state.dart';

class TrackerModuleNameGetBloc
    extends Bloc<TrackerModuleNameGetEvent, TrackerModuleNameGetState> {
  TrackerModuleNameGetBloc({
    required TrackerModuleUseCase trackerModuleUseCase,
  })  : _trackerModuleUseCase = trackerModuleUseCase,
        super(
          const TrackerModuleNameGetInitialState(),
        ) {
    on<GetTrackerModuleNameEvent>(
      (event, emit) async {
        emit(
          const GettingTrackerModuleNameState(),
        );
        final failureOrTrackerModuleEntity =
            await _trackerModuleUseCase.getTrackerModule(
          id: event.id,
          fields: event.fields,
        );
        failureOrTrackerModuleEntity.fold(
          (failure) => add(
            _FailedToGetTrackerModuleNameEvent(
              failure: failure,
            ),
          ),
          (trackerModuleEntity) => add(
            _GotTrackerModuleNameEvent(
              result: trackerModuleEntity.name,
            ),
          ),
        );
      },
    );

    on<_GotTrackerModuleNameEvent>(
      (event, emit) => emit(
        GotTrackerModuleNameState(
          result: event.result,
        ),
      ),
    );

    on<_FailedToGetTrackerModuleNameEvent>(
      (event, emit) => emit(
        FailedToGetTrackerModuleNameState(
          failure: event.failure,
        ),
      ),
    );
  }

  final TrackerModuleUseCase _trackerModuleUseCase;
}
