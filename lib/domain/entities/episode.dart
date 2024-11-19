import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final int id;
  final String name;
  final int? episode;
  final String? summary;
  final String? imageUrl;
  final String? runtime;

  const Episode({
    required this.id,
    required this.name,
    this.episode,
    this.summary,
    this.imageUrl,
    this.runtime,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        episode,
        summary,
        imageUrl,
        runtime,
      ];
}
