import 'package:dartz/dartz.dart';
import 'package:movietv/domain/entities/tv/tv_detail.dart';
import 'package:movietv/domain/repositories/tv_repository.dart';
import 'package:movietv/common/failure.dart';

class GetTvDetail {
  final TvRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
