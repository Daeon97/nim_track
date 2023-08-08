// ignore_for_file: public_member_api_docs

part of 'tracker_modules_detail_bloc.dart';

abstract final class TrackerModulesDetailEvent extends Equatable {
  const TrackerModulesDetailEvent();
}

final class ListTrackerModulesDetailEvent extends TrackerModulesDetailEvent {
  const ListTrackerModulesDetailEvent();

  @override
  List<Object?> get props => [];
}

final class ListedTrackerModulesDetailEvent extends TrackerModulesDetailEvent {
  const ListedTrackerModulesDetailEvent({
    required this.trackerModuleEntities,
  });

  final List<TrackerModuleEntity> trackerModuleEntities;

  @override
  List<Object?> get props => [
        trackerModuleEntities,
      ];
}

final class FailedToListTrackerModulesDetailEvent
    extends TrackerModulesDetailEvent {
  const FailedToListTrackerModulesDetailEvent({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
