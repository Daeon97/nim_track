// ignore_for_file: public_member_api_docs

part of 'all_tracker_modules_or_one_tracker_module_bloc.dart';

abstract final class AllTrackerModulesOrOneTrackerModuleEvent
    extends Equatable {
  const AllTrackerModulesOrOneTrackerModuleEvent();
}

final class GetAllTrackerModulesEvent
    extends AllTrackerModulesOrOneTrackerModuleEvent {
  const GetAllTrackerModulesEvent();

  @override
  List<Object?> get props => [];
}

final class GetOneTrackerModuleEvent
    extends AllTrackerModulesOrOneTrackerModuleEvent {
  const GetOneTrackerModuleEvent({
    required this.id,
  });

  final int id;

  @override
  List<Object?> get props => [
        id,
      ];
}
