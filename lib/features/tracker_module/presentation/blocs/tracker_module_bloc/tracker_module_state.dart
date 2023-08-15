// ignore_for_file: public_member_api_docs

part of 'tracker_module_bloc.dart';

abstract final class TrackerModuleState extends Equatable {
  const TrackerModuleState();
}

final class TrackerModuleInitialState extends TrackerModuleState {
  const TrackerModuleInitialState();

  @override
  List<Object?> get props => [];
}

final class GettingTrackerModuleState extends TrackerModuleState {
  const GettingTrackerModuleState();

  @override
  List<Object?> get props => [];
}

final class GotTrackerModuleState extends TrackerModuleState {
  const GotTrackerModuleState({
    required this.trackerModuleEntity,
  });

  final TrackerModuleEntity trackerModuleEntity;

  @override
  List<Object?> get props => [
        trackerModuleEntity,
      ];
}

final class FailedToGetTrackerModuleState extends TrackerModuleState {
  const FailedToGetTrackerModuleState({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
