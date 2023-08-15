// ignore_for_file: public_member_api_docs

part of 'tracker_module_name_get_bloc.dart';

abstract final class TrackerModuleNameGetEvent extends Equatable {
  const TrackerModuleNameGetEvent();
}

final class GetTrackerModuleNameEvent extends TrackerModuleNameGetEvent {
  const GetTrackerModuleNameEvent({
    required this.id,
    this.fields,
  });

  final int id;
  final List<enums.Field>? fields;

  @override
  List<Object?> get props => [
        id,
        fields,
      ];
}

final class _GotTrackerModuleNameEvent extends TrackerModuleNameGetEvent {
  const _GotTrackerModuleNameEvent({
    required this.result,
  });

  final String? result;

  @override
  List<Object?> get props => [
        result,
      ];
}

final class _FailedToGetTrackerModuleNameEvent
    extends TrackerModuleNameGetEvent {
  const _FailedToGetTrackerModuleNameEvent({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
