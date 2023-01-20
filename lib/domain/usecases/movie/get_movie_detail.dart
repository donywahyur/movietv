import 'package:dartz/dartz.dart';
import 'package:movietv/domain/entities/movie/movie_detail.dart';
import 'package:movietv/domain/repositories/movie_repository.dart';
import 'package:movietv/common/failure.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
