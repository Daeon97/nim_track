// ignore_for_file: public_member_api_docs

part of 'tracker_modules_detail_bloc.dart';

abstract final class TrackerModulesDetailState extends Equatable {
  const TrackerModulesDetailState();
}

final class TrackerModulesDetailInitialState extends TrackerModulesDetailState {
  const TrackerModulesDetailInitialState();

  @override
  List<Object> get props => [];
}

final class ListingTrackerModulesDetailState extends TrackerModulesDetailState {
  const ListingTrackerModulesDetailState();

  @override
  List<Object?> get props => [];
}

final class ListedTrackerModulesDetailState extends TrackerModulesDetailState {
  const ListedTrackerModulesDetailState({
    required this.trackerModuleEntities,
  });

  final List<TrackerModuleEntity> trackerModuleEntities;

  @override
  List<Object?> get props => [
        trackerModuleEntities,
      ];
}

final class FailedToListTrackerModulesDetailState
    extends TrackerModulesDetailState {
  const FailedToListTrackerModulesDetailState({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
