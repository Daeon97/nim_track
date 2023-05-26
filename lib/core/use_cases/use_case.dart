// ignore_for_file: public_member_api_docs, one_member_abstracts

import 'package:dartz/dartz.dart';

abstract class UseCase<L, R> {
  Stream<Either<L, R>> call();
}
