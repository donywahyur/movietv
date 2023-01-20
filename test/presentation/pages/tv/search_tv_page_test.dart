import 'package:movietv/domain/entities/tv/tv.dart';
import 'package:movietv/presentation/bloc/tv/tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movietv/presentation/pages/tv/search_tv_pages.dart';

import '../../../dummy_data/tv_dummy_objects.dart';
import '../../../helpers/bloc_helper.dart';

void main() {
  group('search tv page', () {
    late SearchTvBlocHelper mockSearchBlocTv;

    setUpAll(() {
      mockSearchBlocTv = SearchTvBlocHelper();
      registerFallbackValue(SearchTvEventHelper());
      registerFallbackValue(SearchTvStateHelper());
    });

    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<TvSearchBloc>.value(
        value: mockSearchBlocTv,
        child: MaterialApp(
          home: Scaffold(body: body),
        ),
      );
    }

    tearDown(() {
      mockSearchBlocTv.close();
    });

    final tTv = Tv(
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      title: 'title',
      voteAverage: 1,
      voteCount: 1,
    );

    final List<Tv> tListTv = [tTv];

    testWidgets('should be return List Tvs when success', (tester) async {
      when(() => mockSearchBlocTv.state).thenReturn(TvHasData(tListTv));
      await tester.pumpWidget(_makeTestableWidget(SearchTvPage()));
      await tester.enterText(find.byType(TextField), 'Chucky');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.text('title'), findsWidgets);
    });

    testWidgets('should be return progress loading when loading',
        (tester) async {
      when(() => mockSearchBlocTv.state).thenReturn(TvLoading());

      await tester.pumpWidget(_makeTestableWidget(SearchTvPage()));

      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });
  });
}
