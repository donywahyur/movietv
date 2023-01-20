// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:movietv/presentation/bloc/tv/tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movietv/presentation/pages/tv/watchlist_tvs_page.dart';
import 'package:movietv/presentation/widgets/tv_card_list.dart';

import '../../../dummy_data/tv_dummy_objects.dart';
import '../../../helpers/bloc_helper.dart';

void main() {
  late WatchlistTvBlocHelper watchlistTvBlocHelper;

  setUpAll(() {
    watchlistTvBlocHelper = WatchlistTvBlocHelper();
    registerFallbackValue(WatchlistTvEventHelper());
    registerFallbackValue(WatchlistTvStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistTvBloc>(create: (_) => watchlistTvBlocHelper),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should be show MovieCard List when Watchlist success loaded',
      (WidgetTester tester) async {
    when(() => watchlistTvBlocHelper.state)
        .thenReturn(WatchlistTvHasData(testTvList));

    await tester
        .pumpWidget(_makeTestableWidget(Material(child: WatchlistTvsPage())));

    expect(find.byType(TvCard), findsOneWidget);
  });

  testWidgets('should be show CircularProgress when Watchlist loading',
      (WidgetTester tester) async {
    when(() => watchlistTvBlocHelper.state).thenReturn(TvLoading());

    await tester
        .pumpWidget(_makeTestableWidget(Material(child: WatchlistTvsPage())));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should be show text error when Watchlist error',
      (WidgetTester tester) async {
    when(() => watchlistTvBlocHelper.state)
        .thenReturn(const TvHasError('Failed'));

    await tester
        .pumpWidget(_makeTestableWidget(Material(child: WatchlistTvsPage())));

    expect(find.text('Failed'), findsOneWidget);
  });
}
