import 'package:dartz/dartz.dart';
import 'package:movietv/domain/entities/tv/tv.dart';
import 'package:movietv/domain/repositories/tv_repository.dart';
import 'package:movietv/common/failure.dart';

class GetNowPlayingTvs {
  final TvRepository repository;

  GetNowPlayingTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlayingTvs();
  }
}
