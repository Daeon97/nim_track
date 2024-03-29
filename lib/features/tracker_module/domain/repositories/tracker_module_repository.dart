// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:dartz/dartz.dart';
import 'package:nim_track/core/errors/failure.dart';
import 'package:nim_track/core/utils/enums.dart' as enums;
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';

abstract interface class TrackerModuleRepository {
  Future<Either<Failure, TrackerModuleEntity>> getTrackerModule({
    required int id,
    List<enums.Field>? fields,
  });

  Future<Either<Failure, List<TrackerModuleEntity>>> listTrackerModules({
    List<enums.Field>? fields,
  });

  Future<Either<Failure, String>> updateTrackerModuleName({
    required int id,
    required String name,
  });
}
