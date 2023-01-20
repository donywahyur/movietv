import 'package:dartz/dartz.dart';
import 'package:movietv/common/failure.dart';
import 'package:movietv/domain/entities/movie/movie_detail.dart';
import 'package:movietv/domain/repositories/movie_repository.dart';
import 'package:movietv/domain/entities/tv/tv_detail.dart';
import 'package:movietv/domain/repositories/tv_repository.dart';

class RemoveWatchlist {
  final MovieRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}

class RemoveWatchListTv {
  final TvRepository repository;

  RemoveWatchListTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchList(tv);
  }
}
