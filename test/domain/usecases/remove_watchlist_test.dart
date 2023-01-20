import 'package:dartz/dartz.dart';
import 'package:movietv/domain/usecases/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../dummy_data/tv_dummy_objects.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockMovieRepository mockMovieRepository;
  late RemoveWatchListTv usecaseTv;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = RemoveWatchlist(mockMovieRepository);
    mockTvRepository = MockTvRepository();
    usecaseTv = RemoveWatchListTv(mockTvRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockMovieRepository.removeWatchlist(testMovieDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockMovieRepository.removeWatchlist(testMovieDetail));
    expect(result, Right('Removed from watchlist'));
  });
  test('should remove watchlist tv from repository', () async {
    // arrange
    when(mockTvRepository.removeWatchList(testTvDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecaseTv.execute(testTvDetail);
    // assert
    verify(mockTvRepository.removeWatchList(testTvDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
