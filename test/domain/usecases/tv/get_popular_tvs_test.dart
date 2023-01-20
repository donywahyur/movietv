import 'package:dartz/dartz.dart';
import 'package:movietv/domain/entities/tv/tv.dart';
import 'package:movietv/domain/usecases/tv/get_popular_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetPopularTvs usecase;
  late MockTvRepository mockTvRpository;

  setUp(() {
    mockTvRpository = MockTvRepository();
    usecase = GetPopularTvs(mockTvRpository);
  });

  final tTvs = <Tv>[];

  group('GetPopularTvs Tests', () {
    group('execute', () {
      test(
          'should get list of Tvs from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRpository.getPopularTvs())
            .thenAnswer((_) async => Right(tTvs));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvs));
      });
    });
  });
}
