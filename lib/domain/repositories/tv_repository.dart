import 'package:dartz/dartz.dart';
import 'package:movietv/domain/entities/tv/tv.dart';
import 'package:movietv/domain/entities/tv/tv_detail.dart';
import 'package:movietv/common/failure.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getNowPlayingTvs();
  Future<Either<Failure, List<Tv>>> getPopularTvs();
  Future<Either<Failure, List<Tv>>> getTopRatedTvs();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);
  Future<Either<Failure, List<Tv>>> searchTvs(String query);
  Future<Either<Failure, String>> saveWatchList(TvDetail Tv);
  Future<Either<Failure, String>> removeWatchList(TvDetail Tv);
  Future<bool> isAddedToWatchList(int id);
  Future<Either<Failure, List<Tv>>> getWatchListTvs();
}
