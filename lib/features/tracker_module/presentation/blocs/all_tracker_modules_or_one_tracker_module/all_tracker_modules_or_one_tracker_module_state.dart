// ignore_for_file: public_member_api_docs

part of 'all_tracker_modules_or_one_tracker_module_bloc.dart';

abstract final class AllTrackerModulesOrOneTrackerModuleState
    extends Equatable {
  const AllTrackerModulesOrOneTrackerModuleState();
}

final class AllTrackerModulesOrOneTrackerModuleInitialState
    extends AllTrackerModulesOrOneTrackerModuleState {
  const AllTrackerModulesOrOneTrackerModuleInitialState();

  @override
  List<Object?> get props => [];
}

final class AllTrackerModulesState
    extends AllTrackerModulesOrOneTrackerModuleState {
  const AllTrackerModulesState();

  @override
  List<Object?> get props => [];
}

final class OneTrackerModuleState
    extends AllTrackerModulesOrOneTrackerModuleState {
  const OneTrackerModuleState({
    required this.id,
  });

  final int id;

  @override
  List<Object?> get props => [
        id,
      ];
}
