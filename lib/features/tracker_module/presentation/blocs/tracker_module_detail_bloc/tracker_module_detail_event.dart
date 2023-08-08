// ignore_for_file: public_member_api_docs

part of 'tracker_module_detail_bloc.dart';

abstract final class TrackerModuleDetailEvent extends Equatable {
  const TrackerModuleDetailEvent();
}

final class GetTrackerModuleDetailEvent extends TrackerModuleDetailEvent {
  const GetTrackerModuleDetailEvent({
    required this.id,
  });

  final int id;

  @override
  List<Object?> get props => [
        id,
      ];
}

final class GotTrackerModuleDetailEvent extends TrackerModuleDetailEvent {
  const GotTrackerModuleDetailEvent({
    required this.trackerModuleEntity,
  });

  final TrackerModuleEntity trackerModuleEntity;

  @override
  List<Object?> get props => [
        trackerModuleEntity,
      ];
}

final class FailedToGetTrackerModuleDetailEvent
    extends TrackerModuleDetailEvent {
  const FailedToGetTrackerModuleDetailEvent({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
