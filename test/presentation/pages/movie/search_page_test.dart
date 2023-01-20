import 'package:movietv/domain/entities/movie/movie.dart';
import 'package:movietv/presentation/bloc/movie/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movietv/presentation/pages/movie/search_page.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/bloc_helper.dart';

void main() {
  group('search movie page', () {
    late SearchMovieBlocHelper mockSearchBlocMovie;

    setUpAll(() {
      mockSearchBlocMovie = SearchMovieBlocHelper();
      registerFallbackValue(SearchMovieEventHelper());
      registerFallbackValue(SearchMovieStateHelper());
    });

    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<MovieSearchBloc>.value(
        value: mockSearchBlocMovie,
        child: MaterialApp(
          home: Scaffold(body: body),
        ),
      );
    }

    tearDown(() {
      mockSearchBlocMovie.close();
    });

    final tMovie = Movie(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    final List<Movie> tListMovie = [tMovie];
    testWidgets('should be return List Movies when success', (tester) async {
      when(() => mockSearchBlocMovie.state)
          .thenReturn(MovieHasData(tListMovie));
      await tester.pumpWidget(_makeTestableWidget(SearchPage()));
      await tester.enterText(find.byType(TextField), 'spiderman');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.text('title'), findsWidgets);
    });

    testWidgets('should be return progress loading when loading',
        (tester) async {
      when(() => mockSearchBlocMovie.state).thenReturn(MovieLoading());

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));

      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });
  });
}
