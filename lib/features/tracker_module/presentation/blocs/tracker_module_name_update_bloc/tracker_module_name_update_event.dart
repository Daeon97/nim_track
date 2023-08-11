// ignore_for_file: public_member_api_docs

part of 'tracker_module_name_update_bloc.dart';

abstract final class TrackerModuleNameUpdateEvent extends Equatable {
  const TrackerModuleNameUpdateEvent();
}

final class UpdateTrackerModuleNameEvent extends TrackerModuleNameUpdateEvent {
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

final class _UpdatedTrackerModuleNameEvent
    extends TrackerModuleNameUpdateEvent {
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
    extends TrackerModuleNameUpdateEvent {
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
