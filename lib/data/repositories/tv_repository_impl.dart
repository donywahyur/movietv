import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movietv/data/datasources/tv/tv_local_data_source.dart';
import 'package:movietv/data/datasources/tv/tv_remote_data_source.dart';
import 'package:movietv/data/models/tv/tv_table.dart';
import 'package:movietv/domain/entities/tv/tv.dart';
import 'package:movietv/domain/entities/tv/tv_detail.dart';
import 'package:movietv/domain/repositories/tv_repository.dart';
import 'package:movietv/common/exception.dart';
import 'package:movietv/common/failure.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource remoteDataSource;
  final TvLocalDataSource localDataSource;

  TvRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Tv>>> getNowPlayingTvs() async {
    try {
      final result = await remoteDataSource.getNowPlayingTvs();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularTvs() async {
    try {
      final result = await remoteDataSource.getPopularTvs();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTvs() async {
    try {
      final result = await remoteDataSource.getTopRatedTvs();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTvs(String query) async {
    try {
      final result = await remoteDataSource.searchTvs(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchList(TvDetail tv) async {
    try {
      final result =
          await localDataSource.insertWatchList(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
    // return Right("");
  }

  @override
  Future<Either<Failure, String>> removeWatchList(TvDetail tv) async {
    try {
      final result =
          await localDataSource.removeWatchList(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
    // return Right("");
  }

  @override
  Future<bool> isAddedToWatchList(int id) async {
    final result = await localDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchListTvs() async {
    final result = await localDataSource.getWatchListTvs();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
