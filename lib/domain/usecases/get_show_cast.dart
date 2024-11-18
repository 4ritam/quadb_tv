import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../core/errors/failures.dart';
import '../../core/utils/usecase.dart';
import '../entities/cast.dart';
import '../irepositories/show_repository.dart';

class ShowCastParams extends Equatable {
  final int showId;

  const ShowCastParams({required this.showId});

  @override
  List<Object?> get props => [showId];
}

class GetShowCast implements UseCase<List<Cast>, ShowCastParams> {
  final ShowRepository repository;

  GetShowCast(this.repository);

  @override
  Future<Either<Failure, List<Cast>>> call(ShowCastParams params) async {
    return await repository.getShowCast(params.showId);
  }
}
