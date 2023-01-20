import 'package:dartz/dartz.dart';
import 'package:movietv/domain/usecases/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../dummy_data/tv_dummy_objects.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late SaveWatchlist usecase;
  late MockMovieRepository mockMovieRepository;
  late SaveWatchListTv usecaseTv;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SaveWatchlist(mockMovieRepository);
    mockTvRepository = MockTvRepository();
    usecaseTv = SaveWatchListTv(mockTvRepository);
  });

  test('should save movie to the repository', () async {
    // arrange
    when(mockMovieRepository.saveWatchlist(testMovieDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.saveWatchlist(testMovieDetail));
    expect(result, Right('Added to Watchlist'));
  });
  test('should save tv to the repository', () async {
    // arrange
    when(mockTvRepository.saveWatchList(testTvDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecaseTv.execute(testTvDetail);
    // assert
    verify(mockTvRepository.saveWatchList(testTvDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
