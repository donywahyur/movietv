import 'package:dartz/dartz.dart';
import 'package:movietv/domain/entities/movie/movie.dart';
import 'package:movietv/domain/repositories/movie_repository.dart';
import 'package:movietv/common/failure.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
