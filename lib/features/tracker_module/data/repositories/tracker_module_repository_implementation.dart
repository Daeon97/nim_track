// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:nim_track/core/errors/failures.dart';
import 'package:nim_track/features/tracker_module/data/data_sources/tracker_module_remote_data_source.dart';
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';
import 'package:nim_track/features/tracker_module/domain/repositories/tracker_module_repository.dart';

class TrackerModuleRepositoryImplementation implements TrackerModuleRepository {
  const TrackerModuleRepositoryImplementation({
    required this.trackerModuleRemoteDataSource,
  });

  final TrackerModuleRemoteDataSource trackerModuleRemoteDataSource;

  @override
  Stream<Either<Failure, TrackerModuleEntity>> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}
