import 'package:fpdart/fpdart.dart';

import '../errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// For usecases that don't need parameters
abstract class NoParamsUseCase<Type> {
  Future<Either<Failure, Type>> call();
}
