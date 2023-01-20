// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:movietv/presentation/bloc/tv/tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movietv/presentation/pages/tv/top_rated_tv_page.dart';

import '../../../dummy_data/tv_dummy_objects.dart';
import '../../../helpers/bloc_helper.dart';

void main() {
  late TopRatedTvsBlocHelper topRatedTvsBlocHelper;

  setUpAll(() {
    topRatedTvsBlocHelper = TopRatedTvsBlocHelper();
    registerFallbackValue(TopRatedTvsEventHelper());
    registerFallbackValue(TopRatedTvsStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvsBloc>(
      create: (_) => topRatedTvsBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => topRatedTvsBlocHelper.state).thenReturn(TvLoading());

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => topRatedTvsBlocHelper.state)
        .thenAnswer((invocation) => TvLoading());
    when(() => topRatedTvsBlocHelper.state).thenReturn(TvHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => topRatedTvsBlocHelper.state).thenReturn(TvHasError('Error'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
