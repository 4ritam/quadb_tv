import 'package:flutter_test/flutter_test.dart';
import 'package:quadb_tv/data/models/schedule_model.dart';
import 'package:quadb_tv/data/models/show_model.dart';
import 'package:quadb_tv/domain/entities/show.dart';

void main() {
  final tShowModel = ShowModel(
    id: 1,
    name: 'Test Show',
    genres: ['Drama'],
    status: 'Ended',
    schedule: const ScheduleModel(time: '20:00', days: ['Monday']),
  );

  final tShowJson = {
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
    }
  };

  test(
    'should be a subclass of Show entity',
    () async {
      // assert
      expect(tShowModel, isA<Show>());
    },
  );

  test(
    'should return a valid model from JSON',
    () async {
      // act
      final result = ShowModel.fromJson(tShowJson);

      // assert
      expect(result, tShowModel);
    },
  );

  test(
    'should return a JSON map containing proper data',
    () async {
      // act
      final result = tShowModel.toJson();
      // assert
      final expectedJson = {
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
      };
      expect(result, expectedJson);
    },
  );
}
