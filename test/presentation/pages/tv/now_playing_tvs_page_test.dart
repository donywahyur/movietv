// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:movietv/presentation/bloc/tv/tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movietv/presentation/pages/tv/now_playing_tv_page.dart';

import '../../../dummy_data/tv_dummy_objects.dart';
import '../../../helpers/bloc_helper.dart';

void main() {
  late NowPlayingTvsBlocHelper nowPlayingTvsBlocHelper;

  setUpAll(() {
    nowPlayingTvsBlocHelper = NowPlayingTvsBlocHelper();
    registerFallbackValue(NowPlayingTvsEventHelper());
    registerFallbackValue(NowPlayingTvsStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTvsBloc>(
      create: (_) => nowPlayingTvsBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => nowPlayingTvsBlocHelper.state).thenReturn(TvLoading());

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTvPage()));

    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => nowPlayingTvsBlocHelper.state)
        .thenAnswer((invocation) => TvLoading());
    when(() => nowPlayingTvsBlocHelper.state).thenReturn(TvHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => nowPlayingTvsBlocHelper.state).thenReturn(TvHasError('Error'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
