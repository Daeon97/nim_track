// ignore_for_file: public_member_api_docs

part of 'tracker_modules_bloc.dart';

abstract final class TrackerModulesState extends Equatable {
  const TrackerModulesState();
}

final class TrackerModulesInitialState extends TrackerModulesState {
  const TrackerModulesInitialState();

  @override
  List<Object?> get props => [];
}

final class ListingTrackerModulesState extends TrackerModulesState {
  const ListingTrackerModulesState();

  @override
  List<Object?> get props => [];
}

final class ListedTrackerModulesState extends TrackerModulesState {
  const ListedTrackerModulesState({
    required this.trackerModuleEntities,
  });

  final List<TrackerModuleEntity> trackerModuleEntities;

  @override
  List<Object?> get props => [
        trackerModuleEntities,
      ];
}

final class FailedToListTrackerModulesState extends TrackerModulesState {
  const FailedToListTrackerModulesState({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
