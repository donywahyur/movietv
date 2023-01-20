import 'package:movietv/common/exception.dart';
import 'package:movietv/data/datasources/db/database_helper.dart';
import 'package:movietv/data/models/tv/tv_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchList(TvTable tv);
  Future<String> removeWatchList(TvTable tv);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchListTvs();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchList(TvTable tv) async {
    try {
      await databaseHelper.insertWatchListTv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchList(TvTable tv) async {
    try {
      await databaseHelper.removeWatchListTv(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchListTvs() async {
    final result = await databaseHelper.getWatchListTvs();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }
}
