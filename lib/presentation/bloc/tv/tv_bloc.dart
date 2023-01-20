import 'package:movietv/domain/entities/tv/tv.dart';
import 'package:movietv/domain/entities/tv/tv_detail.dart';
import 'package:movietv/domain/usecases/tv/get_now_playing_tvs.dart';
import 'package:movietv/domain/usecases/tv/get_popular_tvs.dart';
import 'package:movietv/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:movietv/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:movietv/domain/usecases/tv/get_tv_detail.dart';
import 'package:movietv/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:movietv/domain/usecases/tv/search_tvs.dart';
import 'package:movietv/domain/usecases/get_watchlist_status.dart';
import 'package:movietv/domain/usecases/remove_watchlist.dart';
import 'package:movietv/domain/usecases/save_watchlist.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class NowPlayingTvsBloc extends Bloc<TvEvent, TvState> {
  final GetNowPlayingTvs _getOnTheAirTvs;

  NowPlayingTvsBloc(this._getOnTheAirTvs) : super(TvLoading()) {
    on<FetchNowPlayingTvs>((event, emit) async {
      emit(TvLoading());
      final result = await _getOnTheAirTvs.execute();
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tvs) {
        emit(TvHasData(tvs));
      });
    });
  }
}

class PopularTvsBloc extends Bloc<TvEvent, TvState> {
  final GetPopularTvs _getPopularTvs;

  PopularTvsBloc(this._getPopularTvs) : super(TvLoading()) {
    on<FetchPopularTvs>((event, emit) async {
      emit(TvLoading());
      final result = await _getPopularTvs.execute();
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tvs) {
        emit(TvHasData(tvs));
      });
    });
  }
}

class TopRatedTvsBloc extends Bloc<TvEvent, TvState> {
  final GetTopRatedTvs _getTopRatedTvs;

  TopRatedTvsBloc(this._getTopRatedTvs) : super(TvLoading()) {
    on<FetchTopRatedTvs>((event, emit) async {
      emit(TvLoading());
      final result = await _getTopRatedTvs.execute();
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tvs) {
        emit(TvHasData(tvs));
      });
    });
  }
}

class DetailTvBloc extends Bloc<TvEvent, TvState> {
  final GetTvDetail _getTvDetail;
  DetailTvBloc(this._getTvDetail) : super(TvLoading()) {
    on<FetchDetailTvs>((event, emit) async {
      final id = event.id;
      emit(TvLoading());
      final result = await _getTvDetail.execute(id);
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (data) {
        emit(TvDetailHasData(data));
      });
    });
  }
}

class TvRecommendationBloc extends Bloc<TvEvent, TvState> {
  final GetTvRecommendations _getTvRecommendations;
  TvRecommendationBloc(this._getTvRecommendations) : super(TvLoading()) {
    on<FetchRecommendationTvs>((event, emit) async {
      final int id = event.id;
      emit(TvLoading());

      final result = await _getTvRecommendations.execute(id);
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tvs) {
        emit(TvHasData(tvs));
      });
    });
  }
}

class TvSearchBloc extends Bloc<TvEvent, TvState> {
  final SearchTvs _searchTvs;
  TvSearchBloc(this._searchTvs) : super(TvEmpty()) {
    on<FetchTvsSearch>((event, emit) async {
      final String query = event.query;
      emit(TvLoading());

      final result = await _searchTvs.execute(query);
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tvs) {
        emit(TvHasData(tvs));
      });
    });
  }
}

class WatchlistTvBloc extends Bloc<TvEvent, TvState> {
  final GetWatchlistTvs _getWatchlistTvs;
  final GetWatchListStatusTv getWatchListStatus;
  final SaveWatchListTv saveWatchlist;
  final RemoveWatchListTv removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist Movie';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist Movie';

  WatchlistTvBloc(this._getWatchlistTvs, this.getWatchListStatus,
      this.saveWatchlist, this.removeWatchlist)
      : super(TvEmpty()) {
    on<FetchWatchlistTvs>((event, emit) async {
      emit(TvLoading());
      final result = await _getWatchlistTvs.execute();
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tvsData) {
        emit(WatchlistTvHasData(tvsData));
      });
    });

    on<SaveWatchlistTv>((event, emit) async {
      final tv = event.tv;
      emit(TvLoading());
      final result = await saveWatchlist.execute(tv);

      result.fold(
        (failure) => emit(TvHasError(failure.message)),
        (data) => emit(
          WatchlistTvMessage(data),
        ),
      );
    });

    on<RemoveWatchlistTv>((event, emit) async {
      final tv = event.tv;
      emit(TvLoading());

      final result = await removeWatchlist.execute(tv);

      result.fold(
        (failure) => emit(TvHasError(failure.message)),
        (data) => emit(
          WatchlistTvMessage(data),
        ),
      );
    });

    on<LoadWatchlistTvStatus>((event, emit) async {
      final id = event.id;
      emit(TvLoading());
      final result = await getWatchListStatus.execute(id);

      emit(LoadWatchlistTvData(result));
    });
  }
}
