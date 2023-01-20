import 'package:dartz/dartz.dart';
import 'package:movietv/common/failure.dart';
import 'package:movietv/domain/entities/movie/movie.dart';
import 'package:movietv/domain/repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
