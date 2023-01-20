import 'package:dartz/dartz.dart';
import 'package:movietv/domain/entities/tv/tv.dart';
import 'package:movietv/domain/repositories/tv_repository.dart';
import 'package:movietv/common/failure.dart';

class GetWatchlistTvs {
  final TvRepository _repository;

  GetWatchlistTvs(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchListTvs();
  }
}
