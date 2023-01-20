import 'package:dartz/dartz.dart';
import 'package:movietv/domain/entities/movie/movie.dart';
import 'package:movietv/domain/repositories/movie_repository.dart';
import 'package:movietv/common/failure.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
