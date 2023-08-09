// ignore_for_file: public_member_api_docs

part of 'tracker_module_name_bloc.dart';

abstract final class TrackerModuleNameState extends Equatable {
  const TrackerModuleNameState();
}

final class TrackerModuleNameInitialState extends TrackerModuleNameState {
  const TrackerModuleNameInitialState();

  @override
  List<Object?> get props => [];
}

final class UpdatingTrackerModuleNameState extends TrackerModuleNameState {
  const UpdatingTrackerModuleNameState();

  @override
  List<Object?> get props => [];
}

final class UpdatedTrackerModuleNameState extends TrackerModuleNameState {
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
    extends TrackerModuleNameState {
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
