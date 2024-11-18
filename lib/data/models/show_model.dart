import '../../domain/entities/show.dart';
import 'schedule_model.dart';

class ShowModel extends Show {
  const ShowModel({
    required super.id,
    required super.name,
    super.summary,
    required super.genres,
    super.rating,
    super.imageUrl,
    required super.status,
    required super.schedule,
  });

  factory ShowModel.fromJson(Map<String, dynamic> json) {
    return ShowModel(
      id: json['show']['id'],
      name: json['show']['name'],
      summary: json['show']['summary'],
      genres: List<String>.from(json['show']['genres']),
      rating: json['show']['rating']['average']?.toDouble(),
      imageUrl: json['show']['image']?['medium'],
      status: json['show']['status'],
      schedule: ScheduleModel.fromJson(json['show']['schedule']),
    );
  }

  Map<String, dynamic> toJson() => {
        'show': {
          'id': id,
          'name': name,
          'summary': summary,
          'genres': genres,
          'rating': {'average': rating},
          'image': imageUrl != null ? {'medium': imageUrl} : null,
          'status': status,
          'schedule': (schedule as ScheduleModel).toJson(),
        }
      };
}
