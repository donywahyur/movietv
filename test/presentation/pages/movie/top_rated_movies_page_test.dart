// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:movietv/presentation/bloc/movie/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movietv/presentation/pages/movie/top_rated_movies_page.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/bloc_helper.dart';

void main() {
  late TopRatedMoviesBlocHelper topRatedMoviesBlocHelper;

  setUpAll(() {
    topRatedMoviesBlocHelper = TopRatedMoviesBlocHelper();
    registerFallbackValue(TopRatedMoviesEventHelper());
    registerFallbackValue(TopRatedMoviesStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBloc>(
      create: (_) => topRatedMoviesBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => topRatedMoviesBlocHelper.state).thenReturn(MovieLoading());

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => topRatedMoviesBlocHelper.state)
        .thenAnswer((invocation) => MovieLoading());
    when(() => topRatedMoviesBlocHelper.state)
        .thenReturn(MovieHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => topRatedMoviesBlocHelper.state)
        .thenReturn(MovieHasError('Error'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
