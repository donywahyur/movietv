import 'package:dartz/dartz.dart';
import 'package:movietv/common/failure.dart';
import 'package:movietv/domain/entities/movie/movie_detail.dart';
import 'package:movietv/domain/repositories/movie_repository.dart';
import 'package:movietv/domain/entities/tv/tv_detail.dart';
import 'package:movietv/domain/repositories/tv_repository.dart';

class SaveWatchlist {
  final MovieRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}

class SaveWatchListTv {
  final TvRepository repository;

  SaveWatchListTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchList(tv);
  }
}
