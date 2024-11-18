import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quadb_tv/core/errors/failures.dart';
import 'package:quadb_tv/data/models/schedule_model.dart';
import 'package:quadb_tv/data/models/show_model.dart';
import 'package:quadb_tv/data/repositories/show_repository_impl.dart';

import '../../helpers/test_helpers.dart';

void main() {
  late ShowRepositoryImpl repository;
  late MockShowRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockShowRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ShowRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getAllShows', () {
    final tShowModels = [
      ShowModel(
        id: 1,
        name: 'Test Show',
        genres: ['Drama'],
        status: 'Ended',
        schedule: const ScheduleModel(time: '20:00', days: ['Monday']),
      ),
    ];

    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.getAllShows())
            .thenAnswer((_) async => tShowModels);

        // act
        final result = await repository.getAllShows();

        // assert
        verify(() => mockRemoteDataSource.getAllShows());
        expect(result, equals(Right(tShowModels)));
      },
    );

    test(
      'should return network failure when device is offline',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        // act
        final result = await repository.getAllShows();

        // assert
        verifyNever(() => mockRemoteDataSource.getAllShows());
        expect(result, equals(Left(NetworkFailure())));
      },
    );
  });
}
