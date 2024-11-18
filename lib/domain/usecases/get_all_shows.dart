import 'package:fpdart/fpdart.dart';
import 'package:quadb_tv/core/utils/usecase.dart';

import '../../core/errors/failures.dart';
import '../entities/show.dart';
import '../irepositories/show_repository.dart';

class GetAllShows implements NoParamsUseCase<List<Show>> {
  final ShowRepository repository;

  GetAllShows(this.repository);

  @override
  Future<Either<Failure, List<Show>>> call() async {
    return await repository.getAllShows();
  }
}
