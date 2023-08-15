// ignore_for_file: public_member_api_docs

part of 'tracker_modules_detail_bloc.dart';

abstract final class TrackerModulesDetailEvent extends Equatable {
  const TrackerModulesDetailEvent();
}

final class ListTrackerModulesDetailEvent extends TrackerModulesDetailEvent {
  const ListTrackerModulesDetailEvent({
    this.fields,
  });

  final List<enums.Field>? fields;

  @override
  List<Object?> get props => [
        fields,
      ];
}

final class _ListedTrackerModulesDetailEvent extends TrackerModulesDetailEvent {
  const _ListedTrackerModulesDetailEvent({
    required this.trackerModuleEntities,
  });

  final List<TrackerModuleEntity> trackerModuleEntities;

  @override
  List<Object?> get props => [
        trackerModuleEntities,
      ];
}

final class _FailedToListTrackerModulesDetailEvent
    extends TrackerModulesDetailEvent {
  const _FailedToListTrackerModulesDetailEvent({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
