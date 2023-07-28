// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:nim_track/core/errors/failure.dart';
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';
import 'package:nim_track/features/tracker_module/domain/repositories/tracker_module_repository.dart';

class TrackerModuleUseCase {
  const TrackerModuleUseCase({
    required TrackerModuleRepository trackerModuleRepository,
  }) : _trackerModuleRepository = trackerModuleRepository;

  final TrackerModuleRepository _trackerModuleRepository;

  Future<Either<Failure, TrackerModuleEntity>> getTrackerModule({
    required int id,
  }) =>
      _trackerModuleRepository.getTrackerModule(
        id: id,
      );

  Future<Either<Failure, List<TrackerModuleEntity>>> listTrackerModules() =>
      _trackerModuleRepository.listTrackerModules();

  Future<Either<Failure, String>> updateTrackerModuleName({
    required int id,
    required String name,
  }) =>
      _trackerModuleRepository.updateTrackerModuleName(
        id: id,
        name: name,
      );
}
