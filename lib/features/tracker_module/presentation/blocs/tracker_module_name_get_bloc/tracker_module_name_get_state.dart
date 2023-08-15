// ignore_for_file: public_member_api_docs

part of 'tracker_module_name_get_bloc.dart';

abstract final class TrackerModuleNameGetState extends Equatable {
  const TrackerModuleNameGetState();
}

final class TrackerModuleNameGetInitialState extends TrackerModuleNameGetState {
  const TrackerModuleNameGetInitialState();

  @override
  List<Object?> get props => [];
}

final class GettingTrackerModuleNameState extends TrackerModuleNameGetState {
  const GettingTrackerModuleNameState();

  @override
  List<Object?> get props => [];
}

final class GotTrackerModuleNameState extends TrackerModuleNameGetState {
  const GotTrackerModuleNameState({
    required this.result,
  });

  final String? result;

  @override
  List<Object?> get props => [
        result,
      ];
}

final class FailedToGetTrackerModuleNameState
    extends TrackerModuleNameGetState {
  const FailedToGetTrackerModuleNameState({
    required this.failure,
  });

  final Failure failure;

  @override
  List<Object?> get props => [
        failure,
      ];
}
