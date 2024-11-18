import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';

import 'package:quadb_tv/domain/entities/schedule.dart';
import 'package:quadb_tv/domain/usecases/get_all_shows.dart';
import 'package:quadb_tv/domain/entities/show.dart';

import '../../helpers/test_helpers.dart';

void main() {
  late GetAllShows usecase;
  late MockShowRepository mockRepository;

  setUp(() {
    mockRepository = MockShowRepository();
    usecase = GetAllShows(mockRepository);
  });

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
    'should get list of shows from the repository',
    () async {
      // arrange
      when(() => mockRepository.getAllShows())
          .thenAnswer((_) async => Right(tShows));

      // act
      final result = await usecase();

      // assert
      expect(result, Right(tShows));
      verify(() => mockRepository.getAllShows()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
