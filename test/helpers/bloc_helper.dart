import 'package:bloc_test/bloc_test.dart';
import 'package:movietv/presentation/bloc/movie/movie_bloc.dart';
import 'package:movietv/presentation/bloc/tv/tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class NowPlayingMoviesEventHelper extends Fake implements MovieEvent {}

class NowPlayingMoviesStateHelper extends Fake implements MovieState {}

class NowPlayingMoviesBlocHelper extends MockBloc<MovieEvent, MovieState>
    implements NowPlayingMoviesBloc {}

class PopularMoviesEventHelper extends Fake implements MovieEvent {}

class PopularMoviesStateHelper extends Fake implements MovieState {}

class PopularMoviesBlocHelper extends MockBloc<MovieEvent, MovieState>
    implements PopularMoviesBloc {}

class TopRatedMoviesEventHelper extends Fake implements MovieEvent {}

class TopRatedMoviesStateHelper extends Fake implements MovieState {}

class TopRatedMoviesBlocHelper extends MockBloc<MovieEvent, MovieState>
    implements TopRatedMoviesBloc {}

class MovieDetailEventHelper extends Fake implements MovieEvent {}

class MovieDetailStateHelper extends Fake implements MovieState {}

class DetailMovieBlocHelper extends MockBloc<MovieEvent, MovieState>
    implements DetailMovieBloc {}

class MovieRecommendationEventHelper extends Fake implements MovieEvent {}

class MovieRecommendationStateHelper extends Fake implements MovieState {}

class MovieRecommendationBlocHelper extends MockBloc<MovieEvent, MovieState>
    implements MovieRecommendationBloc {}

class WatchlistMovieEventHelper extends Fake implements MovieEvent {}

class WatchlistMovieStateHelper extends Fake implements MovieState {}

class WatchlistMovieBlocHelper extends MockBloc<MovieEvent, MovieState>
    implements WatchlistMovieBloc {}

class SearchMovieEventHelper extends Fake implements MovieEvent {}

class SearchMovieStateHelper extends Fake implements MovieState {}

class SearchMovieBlocHelper extends MockBloc<MovieEvent, MovieState>
    implements MovieSearchBloc {}

class NowPlayingTvsEventHelper extends Fake implements TvEvent {}

class NowPlayingTvsStateHelper extends Fake implements TvState {}

class NowPlayingTvsBlocHelper extends MockBloc<TvEvent, TvState>
    implements NowPlayingTvsBloc {}

class PopularTvsEventHelper extends Fake implements TvEvent {}

class PopularTvsStateHelper extends Fake implements TvState {}

class PopularTvsBlocHelper extends MockBloc<TvEvent, TvState>
    implements PopularTvsBloc {}

class TopRatedTvsEventHelper extends Fake implements TvEvent {}

class TopRatedTvsStateHelper extends Fake implements TvState {}

class TopRatedTvsBlocHelper extends MockBloc<TvEvent, TvState>
    implements TopRatedTvsBloc {}

class DetailTvEventHelper extends Fake implements TvEvent {}

class DetailTvStateHelper extends Fake implements TvState {}

class DetailTvBlocHelper extends MockBloc<TvEvent, TvState>
    implements DetailTvBloc {}

class TvRecommendationEventHelper extends Fake implements TvEvent {}

class TvRecommendationStateHelper extends Fake implements TvState {}

class TvRecommendationBlocHelper extends MockBloc<TvEvent, TvState>
    implements TvRecommendationBloc {}

class WatchlistTvEventHelper extends Fake implements TvEvent {}

class WatchlistTvStateHelper extends Fake implements TvState {}

class WatchlistTvBlocHelper extends MockBloc<TvEvent, TvState>
    implements WatchlistTvBloc {}

class SearchTvEventHelper extends Fake implements TvEvent {}

class SearchTvStateHelper extends Fake implements TvState {}

class SearchTvBlocHelper extends MockBloc<TvEvent, TvState>
    implements TvSearchBloc {}
