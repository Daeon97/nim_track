// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:nim_track/core/errors/failure.dart';

mixin class TrackerModuleRepositoryTransformer {
  Future<Either<Failure, T1>> call<T1, T2>({
    required Future<T2> initiator,
    required Function1<T2, T1> transformer,
  }) async {
    try {
      final maybeModel = await initiator;
      return Right(
        transformer(
          maybeModel,
        ),
      );
    } catch (_) {
      return Left(
        Failure(),
      );
    }
  }
}
