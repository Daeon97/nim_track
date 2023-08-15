// ignore_for_file: public_member_api_docs

part of 'tracker_module_detail_bloc.dart';

abstract final class TrackerModuleDetailState extends Equatable {
  const TrackerModuleDetailState();
}

final class TrackerModuleDetailInitialState extends TrackerModuleDetailState {
  const TrackerModuleDetailInitialState();

  @override
  List<Object> get props => [];
}

final class GettingTrackerModuleDetailState extends TrackerModuleDetailState {
  const GettingTrackerModuleDetailState();

  @override
  List<Object?> get props => [];
}

final class GotTrackerModuleDetailState extends TrackerModuleDetailState {
  const GotTrackerModuleDetailState({
    required this.trackerModuleEntity,
  });

  final TrackerModuleEntity trackerModuleEntity;

  @override
  List<Object?> get props => [
        trackerModuleEntity,
      ];
}

final class FailedToGetTrackerModuleDetailState
    extends TrackerModuleDetailState {
  const FailedToGetTrackerModuleDetailState({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
