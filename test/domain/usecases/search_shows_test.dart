// test/domain/usecases/search_shows_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quadb_tv/domain/entities/schedule.dart';
import 'package:quadb_tv/domain/entities/show.dart';
import 'package:quadb_tv/domain/usecases/search_shows.dart';

import '../../helpers/test_helpers.dart';

void main() {
  late SearchShows usecase;
  late MockShowRepository mockRepository;

  setUp(() {
    mockRepository = MockShowRepository();
    usecase = SearchShows(mockRepository);
  });

  final tQuery = 'test';
  final tShows = [
    Show(
      id: 1,
      name: 'Test Show',
      genres: ['Drama'],
      status: 'Ended',
      schedule: const Schedule(time: '20:00', days: ['Monday']),
    ),
  ];

  test(
    'should get list of shows from the repository based on query',
    () async {
      // arrange
      when(() => mockRepository.searchShows(any()))
          .thenAnswer((_) async => Right(tShows));

      // act
      final result = await usecase(SearchShowsParams(query: tQuery));

      // assert
      expect(result, Right(tShows));
      verify(() => mockRepository.searchShows(tQuery)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
