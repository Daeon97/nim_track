// ignore_for_file: public_member_api_docs

part of 'tracker_modules_bloc.dart';

abstract final class TrackerModulesEvent extends Equatable {
  const TrackerModulesEvent();
}

final class ListTrackerModulesEvent extends TrackerModulesEvent {
  const ListTrackerModulesEvent({
    this.fields,
  });

  final List<enums.Field>? fields;

  @override
  List<Object?> get props => [
        fields,
      ];
}

final class _ListedTrackerModulesEvent extends TrackerModulesEvent {
  const _ListedTrackerModulesEvent({
    required this.trackerModuleEntities,
  });

  final List<TrackerModuleEntity> trackerModuleEntities;

  @override
  List<Object?> get props => [
        trackerModuleEntities,
      ];
}

final class _FailedToListTrackerModulesEvent extends TrackerModulesEvent {
  const _FailedToListTrackerModulesEvent({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
