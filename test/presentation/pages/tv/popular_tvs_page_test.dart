// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:movietv/presentation/bloc/tv/tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movietv/presentation/pages/tv/popular_tv_page.dart';

import '../../../dummy_data/tv_dummy_objects.dart';
import '../../../helpers/bloc_helper.dart';

void main() {
  late PopularTvsBlocHelper popularTvsBlocHelper;

  setUpAll(() {
    popularTvsBlocHelper = PopularTvsBlocHelper();
    registerFallbackValue(PopularTvsEventHelper());
    registerFallbackValue(PopularTvsStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvsBloc>(
      create: (_) => popularTvsBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => popularTvsBlocHelper.state).thenReturn(TvLoading());

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => popularTvsBlocHelper.state)
        .thenAnswer((invocation) => TvLoading());
    when(() => popularTvsBlocHelper.state).thenReturn(TvHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => popularTvsBlocHelper.state).thenReturn(TvHasError('Error'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
