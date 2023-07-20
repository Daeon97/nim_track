// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:dartz/dartz.dart';
import 'package:nim_track/core/errors/failure.dart';
import 'package:nim_track/features/tracker_module/domain/entities/tracker_module_entity.dart';

abstract class TrackerModuleRepository {
  Stream<Either<Failure, TrackerModuleEntity>> call();
}
