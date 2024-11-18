import 'package:equatable/equatable.dart';

class Season extends Equatable {
  final int id;
  final int number;
  final String name;
  final int episodeOrder;
  final String? premiereDate;
  final String? endDate;
  final String? imageUrl;
  final String? summary;

  const Season({
    required this.id,
    required this.number,
    required this.name,
    required this.episodeOrder,
    this.premiereDate,
    this.endDate,
    this.imageUrl,
    this.summary,
  });

  @override
  List<Object?> get props => [
        id,
        number,
        name,
        episodeOrder,
        premiereDate,
        endDate,
        imageUrl,
        summary,
      ];
}
