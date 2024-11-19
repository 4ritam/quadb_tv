import 'package:quadb_tv/core/helper/html_parser.dart';

import '../../domain/entities/episode.dart';

class EpisodeModel extends Episode {
  const EpisodeModel({
    required super.id,
    required super.name,
    super.episode,
    super.summary,
    super.imageUrl,
    super.runtime,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    int minutes =
        json['runtime'] is double ? json['runtime'].toInt() : json['runtime'];
    int hours = minutes ~/ 60;
    if (hours > 0) {
      minutes %= 60;
    }
    return EpisodeModel(
        id: json['id'],
        name: json['name'],
        episode: json['number'],
        summary: htmlParse(json['summary'])?.trim(),
        imageUrl: json['image']?['medium'] ?? json['image']?['original'],
        runtime: '${hours}h ${minutes}m');
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'number': episode,
        'summary': summary,
        'image': {'medium': imageUrl},
        'runtime': runtime,
      };
}
