import 'package:dartz/dartz.dart';
import 'package:movietv/common/failure.dart';
import 'package:movietv/domain/entities/movie/movie.dart';
import 'package:movietv/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
