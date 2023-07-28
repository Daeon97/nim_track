// ignore_for_file: public_member_api_docs

part of 'tracker_modules_bloc.dart';

abstract final class TrackerModulesEvent extends Equatable {
  const TrackerModulesEvent();
}

final class ListTrackerModulesEvent extends TrackerModulesEvent {
  const ListTrackerModulesEvent();

  @override
  List<Object?> get props => [];
}

final class ListedTrackerModulesEvent extends TrackerModulesEvent {
  const ListedTrackerModulesEvent({
    required this.trackerModuleEntities,
  });

  final List<TrackerModuleEntity> trackerModuleEntities;

  @override
  List<Object?> get props => [
        trackerModuleEntities,
      ];
}

final class FailedToListTrackerModulesEvent extends TrackerModulesEvent {
  const FailedToListTrackerModulesEvent({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
