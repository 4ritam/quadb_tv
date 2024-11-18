import 'package:equatable/equatable.dart';

import 'schedule.dart';

class Show extends Equatable {
  final int id;
  final String name;
  final String? summary;
  final List<String> genres;
  final double? rating;
  final String? imageUrl;
  final String status;
  final Schedule schedule;

  const Show({
    required this.id,
    required this.name,
    this.summary,
    required this.genres,
    this.rating,
    this.imageUrl,
    required this.status,
    required this.schedule,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        summary,
        genres,
        rating,
        imageUrl,
        status,
        schedule,
      ];
}
