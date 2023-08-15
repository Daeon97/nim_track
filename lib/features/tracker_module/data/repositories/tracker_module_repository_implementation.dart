// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:nim_track/core/errors/failure.dart';
import 'package:nim_track/core/utils/clients/tracker_module_repository_transformer.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/features/tracker_module/data/data_sources/tracker_module_remote_data_source.dart';
import 'package:nim_track/features/tracker_module/data/models/tracker_module_model.dart';
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';
import 'package:nim_track/features/tracker_module/domain/repositories/tracker_module_repository.dart';

class TrackerModuleRepositoryImplementation
    with TrackerModuleRepositoryTransformer
    implements TrackerModuleRepository {
  const TrackerModuleRepositoryImplementation({
    required TrackerModuleRemoteDataSource trackerModuleRemoteDataSource,
  }) : _trackerModuleRemoteDataSource = trackerModuleRemoteDataSource;

  final TrackerModuleRemoteDataSource _trackerModuleRemoteDataSource;

  @override
  Future<Either<Failure, TrackerModuleEntity>> getTrackerModule({
    required int id,
    List<enums.Field>? fields,
  }) =>
      call<TrackerModuleEntity, TrackerModuleModel>(
        initiator: _trackerModuleRemoteDataSource.getTrackerModule(
          id: id,
          fields: fields,
        ),
        transformer: (
          trackerModuleModel,
        ) =>
            trackerModuleModel,
      );

  @override
  Future<Either<Failure, List<TrackerModuleEntity>>> listTrackerModules({
    List<enums.Field>? fields,
  }) =>
      call<List<TrackerModuleEntity>, List<TrackerModuleModel>>(
        initiator: _trackerModuleRemoteDataSource.listTrackerModules(
          fields: fields,
        ),
        transformer: (
          trackerModuleModel,
        ) =>
            trackerModuleModel,
      );

  @override
  Future<Either<Failure, String>> updateTrackerModuleName({
    required int id,
    required String name,
  }) =>
      call<String, String>(
        initiator: _trackerModuleRemoteDataSource.updateTrackerModuleName(
          id: id,
          name: name,
        ),
        transformer: (
          string,
        ) =>
            string,
      );
}
