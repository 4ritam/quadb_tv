import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final int id;
  final String name;
  final int? season;
  final int? episode;
  final String? summary;
  final String? imageUrl;
  final double? rating;
  final String? airdate;

  const Episode({
    required this.id,
    required this.name,
    this.season,
    this.episode,
    this.summary,
    this.imageUrl,
    this.rating,
    this.airdate,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        season,
        episode,
        summary,
        imageUrl,
        rating,
        airdate,
      ];
}
