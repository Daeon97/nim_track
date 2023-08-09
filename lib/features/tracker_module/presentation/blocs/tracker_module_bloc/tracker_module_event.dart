// ignore_for_file: public_member_api_docs

part of 'tracker_module_bloc.dart';

abstract final class TrackerModuleEvent extends Equatable {
  const TrackerModuleEvent();
}

final class GetTrackerModuleEvent extends TrackerModuleEvent {
  const GetTrackerModuleEvent({
    required this.id,
  });

  final int id;

  @override
  List<Object?> get props => [
        id,
      ];
}

final class _GotTrackerModuleEvent extends TrackerModuleEvent {
  const _GotTrackerModuleEvent({
    required this.trackerModuleEntity,
  });

  final TrackerModuleEntity trackerModuleEntity;

  @override
  List<Object?> get props => [
        trackerModuleEntity,
      ];
}

final class _FailedToGetTrackerModuleEvent extends TrackerModuleEvent {
  const _FailedToGetTrackerModuleEvent({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
