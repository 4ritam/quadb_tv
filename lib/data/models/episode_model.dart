import '../../domain/entities/episode.dart';

class EpisodeModel extends Episode {
  const EpisodeModel({
    required super.id,
    required super.name,
    super.season,
    super.episode,
    super.summary,
    super.imageUrl,
    super.rating,
    super.airdate,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'],
      name: json['name'],
      season: json['season'],
      episode: json['number'],
      summary: json['summary'],
      imageUrl: json['image']?['medium'],
      rating: json['rating']['average']?.toDouble(),
      airdate: json['airdate'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'season': season,
        'number': episode,
        'summary': summary,
        'image': {'medium': imageUrl},
        'rating': {'average': rating},
        'airdate': airdate,
      };
}
