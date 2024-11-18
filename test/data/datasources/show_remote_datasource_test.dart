import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:quadb_tv/core/constants/api_constants.dart';
import 'package:quadb_tv/core/errors/failures.dart';
import 'package:quadb_tv/data/datasources/show_remote_datasource.dart';
import 'package:quadb_tv/data/models/show_model.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ShowRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(Uri.parse('https://dummy-url.com'));
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ShowRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getAllShows', () {
    final tShowsJson = [
      {
        'show': {
          'id': 1,
          'name': 'Test Show',
          'genres': ['Drama'],
          'status': 'Ended',
          'schedule': {
            'time': '20:00',
            'days': ['Monday']
          },
          'rating': {'average': null},
          'image': null,
          'summary': null
        }
      }
    ];

    test(
      'should perform a GET request on a URL with application/json header',
      () async {
        // arrange
        when(() => mockHttpClient.get(any())).thenAnswer(
            (_) async => http.Response(json.encode(tShowsJson), 200));

        // act
        await dataSource.getAllShows();

        // assert
        verify(() => mockHttpClient.get(
              Uri.parse(ApiConstants.getAllShowsUrl()),
            )).called(1);
      },
    );

    test(
      'should return List<ShowModel> when the response code is 200',
      () async {
        // arrange
        when(() => mockHttpClient.get(any())).thenAnswer(
            (_) async => http.Response(json.encode(tShowsJson), 200));

        // act
        final result = await dataSource.getAllShows();

        // assert
        expect(result, isA<List<ShowModel>>());
      },
    );

    test(
      'should throw a ServerException when the response code is not 200',
      () async {
        // arrange
        when(() => mockHttpClient.get(any())).thenAnswer(
            (_) async => http.Response('Something went wrong', 404));

        // act
        final call = dataSource.getAllShows;

        // assert
        expect(() => call(), throwsA(isA<ServerFailure>()));
      },
    );
  });
}
