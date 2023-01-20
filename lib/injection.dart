import 'package:movietv/common/ssl_helper.dart';
import 'package:movietv/data/datasources/db/database_helper.dart';
import 'package:movietv/data/datasources/movie/movie_local_data_source.dart';
import 'package:movietv/data/datasources/movie/movie_remote_data_source.dart';
import 'package:movietv/data/datasources/tv/tv_remote_data_source.dart';
import 'package:movietv/data/datasources/tv/tv_local_data_source.dart';

import 'package:movietv/data/repositories/movie_repository_impl.dart';
import 'package:movietv/domain/repositories/movie_repository.dart';
import 'package:movietv/data/repositories/tv_repository_impl.dart';
import 'package:movietv/domain/repositories/tv_repository.dart';

import 'package:movietv/domain/usecases/movie/get_movie_detail.dart';
import 'package:movietv/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:movietv/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:movietv/domain/usecases/movie/get_popular_movies.dart';
import 'package:movietv/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:movietv/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:movietv/domain/usecases/get_watchlist_status.dart';
import 'package:movietv/domain/usecases/remove_watchlist.dart';
import 'package:movietv/domain/usecases/save_watchlist.dart';
import 'package:movietv/domain/usecases/movie/search_movies.dart';
import 'package:movietv/domain/usecases/tv/get_now_playing_tvs.dart';
import 'package:movietv/domain/usecases/tv/get_popular_tvs.dart';
import 'package:movietv/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:movietv/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:movietv/domain/usecases/tv/search_tvs.dart';
import 'package:movietv/domain/usecases/tv/get_tv_detail.dart';
import 'package:movietv/domain/usecases/tv/get_tv_recommendations.dart';

import 'package:movietv/presentation/bloc/movie/movie_bloc.dart';
import 'package:movietv/presentation/bloc/tv/tv_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory(() => DetailMovieBloc(locator()));
  locator.registerFactory(() => MovieRecommendationBloc(locator()));
  locator.registerFactory(() => MovieSearchBloc(locator()));
  locator.registerFactory(
      () => WatchlistMovieBloc(locator(), locator(), locator(), locator()));
  locator.registerFactory(() => NowPlayingTvsBloc(locator()));
  locator.registerFactory(() => PopularTvsBloc(locator()));
  locator.registerFactory(() => TopRatedTvsBloc(locator()));
  locator.registerFactory(() => DetailTvBloc(locator()));
  locator.registerFactory(() => TvRecommendationBloc(locator()));
  locator.registerFactory(() => TvSearchBloc(locator()));
  locator.registerFactory(
      () => WatchlistTvBloc(locator(), locator(), locator(), locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTvs(locator()));
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchListTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchListTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: SSLHelper.client));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: SSLHelper.client));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => SSLHelper.client);
}
