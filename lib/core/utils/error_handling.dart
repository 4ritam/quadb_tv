import '../errors/failures.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case const (ServerFailure):
      return (failure as ServerFailure).message;
    case const (NetworkFailure):
      return (failure as NetworkFailure).message;
    case const (CacheFailure):
      return (failure as CacheFailure).message;
    default:
      return 'Unexpected Error';
  }
}
