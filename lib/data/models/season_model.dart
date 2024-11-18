import '../../domain/entities/season.dart';

class SeasonModel extends Season {
  const SeasonModel({
    required super.id,
    required super.number,
    required super.name,
    required super.episodeOrder,
    super.premiereDate,
    super.endDate,
    super.imageUrl,
    super.summary,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) {
    return SeasonModel(
      id: json['id'],
      number: json['number'],
      name: json['name'],
      episodeOrder: json['episodeOrder'] ?? 0,
      premiereDate: json['premiereDate'],
      endDate: json['endDate'],
      imageUrl: json['image']?['medium'],
      summary: json['summary'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'number': number,
        'name': name,
        'episodeOrder': episodeOrder,
        'premiereDate': premiereDate,
        'endDate': endDate,
        'image': {'medium': imageUrl},
        'summary': summary,
      };
}
