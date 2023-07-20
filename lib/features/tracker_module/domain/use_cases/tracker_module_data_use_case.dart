// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:nim_track/core/errors/failure.dart';
import 'package:nim_track/core/use_cases/use_case.dart';
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';
import 'package:nim_track/features/tracker_module/domain/repositories/tracker_module_repository.dart';

class TrackerModuleDataUseCase
    implements UseCase<Failure, TrackerModuleEntity> {
  const TrackerModuleDataUseCase({
    required this.trackerModuleRepository,
  });

  final TrackerModuleRepository trackerModuleRepository;

  @override
  Stream<Either<Failure, TrackerModuleEntity>> call() =>
      trackerModuleRepository();
}
