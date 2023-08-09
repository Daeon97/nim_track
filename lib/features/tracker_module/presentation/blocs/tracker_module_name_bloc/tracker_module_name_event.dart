// ignore_for_file: public_member_api_docs

part of 'tracker_module_name_bloc.dart';

abstract final class TrackerModuleNameEvent extends Equatable {
  const TrackerModuleNameEvent();
}

final class UpdateTrackerModuleNameEvent extends TrackerModuleNameEvent {
  const UpdateTrackerModuleNameEvent({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}

final class _UpdatedTrackerModuleNameEvent extends TrackerModuleNameEvent {
  const _UpdatedTrackerModuleNameEvent({
    required this.result,
  });

  final String result;

  @override
  List<Object?> get props => [
        result,
      ];
}

final class _FailedToUpdateTrackerModuleNameEvent
    extends TrackerModuleNameEvent {
  const _FailedToUpdateTrackerModuleNameEvent({
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
