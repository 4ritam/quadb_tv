import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({this.message = 'Server Error'});

  @override
  List<Object> get props => [message];
}

class NetworkFailure extends Failure {
  final String message;

  NetworkFailure({this.message = 'No Internet Connection'});

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  final String message;

  CacheFailure({this.message = 'Cache Error'});

  @override
  List<Object> get props => [message];
}
