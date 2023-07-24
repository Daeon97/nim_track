// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:nim_track/core/errors/failure.dart';
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';
import 'package:nim_track/features/tracker_module/domain/repositories/tracker_module_repository.dart';

class TrackerModuleDataUseCase {
  const TrackerModuleDataUseCase({
    required this.trackerModuleRepository,
  });

  final TrackerModuleRepository trackerModuleRepository;

  Stream<Either<Failure, TrackerModuleEntity>> call() =>
      trackerModuleRepository();
}
