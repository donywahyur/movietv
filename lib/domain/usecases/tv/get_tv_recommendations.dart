import 'package:dartz/dartz.dart';
import 'package:movietv/domain/entities/tv/tv.dart';
import 'package:movietv/domain/repositories/tv_repository.dart';
import 'package:movietv/common/failure.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
