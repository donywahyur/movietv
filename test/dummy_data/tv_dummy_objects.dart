import 'package:movietv/data/models/tv/tv_table.dart';
import 'package:movietv/domain/entities/genre.dart';
import 'package:movietv/domain/entities/tv/tv.dart';
import 'package:movietv/domain/entities/tv/tv_detail.dart';

final testTv = Tv(
  backdropPath: '/rkB4LyZHo1NHXFEDHl9vSD9r1lI.jpg',
  genreIds: [16, 0765, 10759, 18],
  id: 94605,
  originalTitle: 'Arcane',
  overview:
      'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
  popularity: 60.441,
  posterPath: '/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg',
  releaseDate: '2021-11-06',
  title: 'Arcane',
  voteAverage: 8.7,
  voteCount: 2689,
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};
