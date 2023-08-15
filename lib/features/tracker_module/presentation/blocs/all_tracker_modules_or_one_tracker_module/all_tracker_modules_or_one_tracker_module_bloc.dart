// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'all_tracker_modules_or_one_tracker_module_event.dart';

part 'all_tracker_modules_or_one_tracker_module_state.dart';

class AllTrackerModulesOrOneTrackerModuleBloc extends Bloc<
    AllTrackerModulesOrOneTrackerModuleEvent,
    AllTrackerModulesOrOneTrackerModuleState> {
  AllTrackerModulesOrOneTrackerModuleBloc()
      : super(
          const AllTrackerModulesOrOneTrackerModuleInitialState(),
        ) {
    on<GetAllTrackerModulesEvent>(
      (_, emit) => emit(
        const AllTrackerModulesState(),
      ),
    );

    on<GetOneTrackerModuleEvent>(
      (event, emit) => emit(
        OneTrackerModuleState(
          id: event.id,
        ),
      ),
    );
  }
}
