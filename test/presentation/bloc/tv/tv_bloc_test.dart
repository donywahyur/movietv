import 'package:movietv/presentation/bloc/tv/tv_bloc.dart';
import 'package:movietv/domain/entities/tv/tv.dart';
import 'package:movietv/domain/entities/tv/tv_detail.dart';
import 'package:movietv/domain/entities/genre.dart';
import 'package:movietv/common/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_bloc_test.mocks.dart';
import 'package:bloc_test/bloc_test.dart';

@GenerateMocks([
  MockGetNowPlayingTvs,
  MockGetPopularTvs,
  MockGetTopRatedTvs,
  MockGetTvDetail,
  MockGetTvRecommendations,
  MockGetWatchlistTvs,
  MockGetWatchListStatus,
  MockSaveWatchlistTv,
  MockRemoveWatchlistTv
])
void main() {
  late NowPlayingTvsBloc nowPlayingTvsBloc;
  late PopularTvsBloc popularTvsBloc;
  late TopRatedTvsBloc topRatedTvsBloc;
  late DetailTvBloc detailTvBloc;
  late TvRecommendationBloc tvRecommendationBloc;
  late WatchlistTvBloc watchlistTvBloc;

  late MockGetNowPlayingTvs mockGetNowPlayingTvs;
  late MockGetPopularTvs mockGetPopularTvs;
  late MockGetTopRatedTvs mockGetTopRatedTvs;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchlistTvs mockGetWatchlistTvs;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveWatchlistTv mockRemoveWatchlistTvs;
  late MockSaveWatchlistTv mockSaveWatchlistTvs;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetNowPlayingTvs = MockGetNowPlayingTvs();
    mockGetPopularTvs = MockGetPopularTvs();
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    mockSaveWatchlistTvs = MockSaveWatchlistTv();
    mockRemoveWatchlistTvs = MockRemoveWatchlistTv();
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    mockGetWatchListStatus = MockGetWatchListStatus();

    nowPlayingTvsBloc = NowPlayingTvsBloc(mockGetNowPlayingTvs);
    popularTvsBloc = PopularTvsBloc(mockGetPopularTvs);
    topRatedTvsBloc = TopRatedTvsBloc(mockGetTopRatedTvs);
    tvRecommendationBloc = TvRecommendationBloc(mockGetTvRecommendations);
    detailTvBloc = DetailTvBloc(mockGetTvDetail);
    watchlistTvBloc = WatchlistTvBloc(mockGetWatchlistTvs,
        mockGetWatchListStatus, mockSaveWatchlistTvs, mockRemoveWatchlistTvs);
  });

  final tTv = Tv(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tTvList = <Tv>[tTv];

  final tTvDetail = TvDetail(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    id: 557,
    originalTitle: 'Spider-Man',
    genres: [Genre(id: 1, name: 'name')],
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  const tId = 1;

  group('Get now playing tvs', () {
    test('initial state must be empty', () {
      expect(nowPlayingTvsBloc.state, TvLoading());
    });

    blocTest(
      'should emit[loading, TvHasData] when data is gotten succesfully',
      build: () {
        when(mockGetNowPlayingTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return nowPlayingTvsBloc;
      },
      act: (NowPlayingTvsBloc bloc) => bloc.add(FetchNowPlayingTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvLoading(), TvHasData(tTvList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetNowPlayingTvs.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return nowPlayingTvsBloc;
      },
      act: (NowPlayingTvsBloc bloc) => bloc.add(FetchNowPlayingTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        const TvHasError('Server Failure'),
      ],
      verify: (NowPlayingTvsBloc bloc) =>
          verify(mockGetNowPlayingTvs.execute()),
    );
  });

  group('Get Popular tvs', () {
    test('initial state must be empty', () {
      expect(popularTvsBloc.state, TvLoading());
    });

    blocTest(
      'should emit[loading, TvHasData] when data is gotten succesfully',
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return popularTvsBloc;
      },
      act: (PopularTvsBloc bloc) => bloc.add(FetchPopularTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvLoading(), TvHasData(tTvList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetPopularTvs.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return popularTvsBloc;
      },
      act: (PopularTvsBloc bloc) => bloc.add(FetchPopularTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        const TvHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetPopularTvs.execute()),
    );
  });

  group('Get Top Rated Tvs', () {
    test('initial state must be empty', () {
      expect(topRatedTvsBloc.state, TvLoading());
    });

    blocTest(
      'should emit[loading, TvHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return topRatedTvsBloc;
      },
      act: (TopRatedTvsBloc bloc) => bloc.add(FetchTopRatedTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvLoading(), TvHasData(tTvList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTopRatedTvs.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return topRatedTvsBloc;
      },
      act: (TopRatedTvsBloc bloc) => bloc.add(FetchTopRatedTvs()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        const TvHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTopRatedTvs.execute()),
    );
  });

  group('Get Recommended tvs', () {
    test('initial state must be empty', () {
      expect(tvRecommendationBloc.state, TvLoading());
    });

    blocTest(
      'should emit[loading, TvHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvList));
        return tvRecommendationBloc;
      },
      act: (TvRecommendationBloc bloc) =>
          bloc.add(const FetchRecommendationTvs(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvLoading(), TvHasData(tTvList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvRecommendations.execute(tId)).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return tvRecommendationBloc;
      },
      act: (TvRecommendationBloc bloc) =>
          bloc.add(const FetchRecommendationTvs(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        const TvHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTvRecommendations.execute(tId)),
    );
  });

  group('Get Details tvs', () {
    test('initial state must be empty', () {
      expect(detailTvBloc.state, TvLoading());
    });

    blocTest(
      'should emit[loading, TvHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(tTvDetail));
        return detailTvBloc;
      },
      act: (DetailTvBloc bloc) => bloc.add(const FetchDetailTvs(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [TvLoading(), TvDetailHasData(tTvDetail)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvDetail.execute(tId)).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return detailTvBloc;
      },
      act: (DetailTvBloc bloc) => bloc.add(const FetchDetailTvs(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        const TvHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTvDetail.execute(tId)),
    );
  });

  group('Get Watchlist Tvs', () {
    test('initial state must be empty', () {
      expect(watchlistTvBloc.state, TvEmpty());
    });

    group('Watchlist Tv', () {
      test('initial state should be empty', () {
        expect(watchlistTvBloc.state, TvEmpty());
      });

      group('Fetch Watchlist Tv', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockGetWatchlistTvs.execute())
                .thenAnswer((_) async => Right(tTvList));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) => bloc.add(FetchWatchlistTvs()),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            WatchlistTvHasData(tTvList),
          ],
          verify: (bloc) => verify(mockGetWatchlistTvs.execute()),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockGetWatchlistTvs.execute())
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) => bloc.add(FetchWatchlistTvs()),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            const TvHasError('Server Failure'),
          ],
          verify: (bloc) => verify(mockGetWatchlistTvs.execute()),
        );
      });

      group('Load Watchlist Tv', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockGetWatchListStatus.execute(tId))
                .thenAnswer((_) async => true);
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) =>
              bloc.add(const LoadWatchlistTvStatus(tId)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            const LoadWatchlistTvData(true),
          ],
          verify: (bloc) => verify(mockGetWatchListStatus.execute(tId)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockGetWatchListStatus.execute(tId))
                .thenAnswer((_) async => false);
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) =>
              bloc.add(const LoadWatchlistTvStatus(tId)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            const LoadWatchlistTvData(false),
          ],
          verify: (bloc) => verify(mockGetWatchListStatus.execute(tId)),
        );
      });

      group('Save Watchlist Tv', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockSaveWatchlistTvs.execute(tTvDetail)).thenAnswer(
                (_) async => Right(WatchlistTvBloc.watchlistAddSuccessMessage));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) => bloc.add(SaveWatchlistTv(tTvDetail)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            const WatchlistTvMessage(
                WatchlistTvBloc.watchlistAddSuccessMessage),
          ],
          verify: (bloc) => verify(mockSaveWatchlistTvs.execute(tTvDetail)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockSaveWatchlistTvs.execute(tTvDetail))
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) => bloc.add(SaveWatchlistTv(tTvDetail)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            const TvHasError('Server Failure'),
          ],
          verify: (bloc) => verify(mockSaveWatchlistTvs.execute(tTvDetail)),
        );
      });

      group('Remove Watchlist Tv', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockRemoveWatchlistTvs.execute(tTvDetail)).thenAnswer(
                (_) async => Right(WatchlistTvBloc.watchlistAddSuccessMessage));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) => bloc.add(RemoveWatchlistTv(tTvDetail)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            const WatchlistTvMessage(
                WatchlistTvBloc.watchlistAddSuccessMessage),
          ],
          verify: (bloc) => verify(mockRemoveWatchlistTvs.execute(tTvDetail)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockRemoveWatchlistTvs.execute(tTvDetail))
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            return watchlistTvBloc;
          },
          act: (WatchlistTvBloc bloc) => bloc.add(RemoveWatchlistTv(tTvDetail)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            TvLoading(),
            const TvHasError('Server Failure'),
          ],
          verify: (bloc) => verify(mockRemoveWatchlistTvs.execute(tTvDetail)),
        );
      });
    });
  });
}
