// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:movietv/presentation/bloc/tv/tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movietv/presentation/pages/tv/tv_detail_page.dart';

import '../../../dummy_data/tv_dummy_objects.dart';
import '../../../helpers/bloc_helper.dart';

void main() {
  late DetailTvBlocHelper detailTvBlocHelper;
  late TvRecommendationBlocHelper tvRecommendationBlocHelper;
  late WatchlistTvBlocHelper watchlistTvBlocHelper;

  setUpAll(() {
    detailTvBlocHelper = DetailTvBlocHelper();
    registerFallbackValue(DetailTvEventHelper());
    registerFallbackValue(DetailTvStateHelper());

    tvRecommendationBlocHelper = TvRecommendationBlocHelper();
    registerFallbackValue(TvRecommendationEventHelper());
    registerFallbackValue(TvRecommendationStateHelper());

    watchlistTvBlocHelper = WatchlistTvBlocHelper();
    registerFallbackValue(WatchlistTvEventHelper());
    registerFallbackValue(WatchlistTvStateHelper());
    registerFallbackValue(PopularTvsEventHelper());
    registerFallbackValue(PopularTvsStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTvBloc>(create: (_) => detailTvBlocHelper),
        BlocProvider<WatchlistTvBloc>(
          create: (_) => watchlistTvBlocHelper,
        ),
        BlocProvider<TvRecommendationBloc>(
          create: (_) => tvRecommendationBlocHelper,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => detailTvBlocHelper.state).thenReturn(TvLoading());
    when(() => watchlistTvBlocHelper.state).thenReturn(TvLoading());
    when(() => tvRecommendationBlocHelper.state).thenReturn(TvLoading());

    final circularProgress = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(
      id: 1,
    )));
    await tester.pump();

    expect(circularProgress, findsOneWidget);
  });
  testWidgets(
      'Watchlist button should display + icon when Tv not added to watch list',
      (WidgetTester tester) async {
    when(() => detailTvBlocHelper.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => tvRecommendationBlocHelper.state)
        .thenReturn(TvHasData(testTvList));
    when(() => watchlistTvBlocHelper.state)
        .thenReturn(LoadWatchlistTvData(false));

    final watchListButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 97080)));
    await tester.pump();
    expect(watchListButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie added to watch list',
      (WidgetTester tester) async {
    when(() => detailTvBlocHelper.state)
        .thenReturn(TvDetailHasData(testTvDetail));

    when(() => tvRecommendationBlocHelper.state)
        .thenReturn(TvHasData(testTvList));
    when(() => watchlistTvBlocHelper.state)
        .thenReturn(LoadWatchlistTvData(true));

    final watchListButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 97080)));
    expect(watchListButtonIcon, findsOneWidget);
  });
}
