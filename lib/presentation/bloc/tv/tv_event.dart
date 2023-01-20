part of 'tv_bloc.dart';

abstract class TvEvent extends Equatable {
  const TvEvent();
  @override
  List<Object> get props => [];
}

class FetchNowPlayingTvs extends TvEvent {}

class FetchPopularTvs extends TvEvent {}

class FetchTopRatedTvs extends TvEvent {}

class FetchDetailTvs extends TvEvent {
  final int id;
  const FetchDetailTvs(this.id);

  @override
  List<Object> get props => [id];
}

class FetchRecommendationTvs extends TvEvent {
  final int id;
  const FetchRecommendationTvs(this.id);

  @override
  List<Object> get props => [id];
}

class FetchTvsSearch extends TvEvent {
  final String query;
  const FetchTvsSearch(this.query);

  @override
  List<Object> get props => [query];
}

class FetchWatchlistTvs extends TvEvent {}

class SaveWatchlistTv extends TvEvent {
  final TvDetail tv;

  const SaveWatchlistTv(this.tv);
  @override
  List<Object> get props => [tv];
}

class RemoveWatchlistTv extends TvEvent {
  final TvDetail tv;

  const RemoveWatchlistTv(this.tv);
  @override
  List<Object> get props => [tv];
}

class LoadWatchlistTvStatus extends TvEvent {
  final int id;
  const LoadWatchlistTvStatus(this.id);

  @override
  List<Object> get props => [id];
}
