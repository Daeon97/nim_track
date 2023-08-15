// ignore_for_file: public_member_api_docs

part of 'tracker_module_name_update_bloc.dart';

abstract final class TrackerModuleNameUpdateState extends Equatable {
  const TrackerModuleNameUpdateState();
}

final class TrackerModuleNameUpdateInitialState
    extends TrackerModuleNameUpdateState {
  const TrackerModuleNameUpdateInitialState();

  @override
  List<Object?> get props => [];
}

final class UpdatingTrackerModuleNameState
    extends TrackerModuleNameUpdateState {
  const UpdatingTrackerModuleNameState();

  @override
  List<Object?> get props => [];
}

final class UpdatedTrackerModuleNameState extends TrackerModuleNameUpdateState {
  const UpdatedTrackerModuleNameState({
    required this.result,
  });

  final String result;

  @override
  List<Object?> get props => [
        result,
      ];
}

final class FailedToUpdateTrackerModuleNameState
    extends TrackerModuleNameUpdateState {
  const FailedToUpdateTrackerModuleNameState({
    required this.id,
    required this.name,
    required this.failure,
  });

  final int id;
  final String name;
  final Failure failure;

  @override
  List<Object?> get props => [
        id,
        name,
        failure,
      ];
}
