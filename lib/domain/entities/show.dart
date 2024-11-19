import 'package:equatable/equatable.dart';

class Show extends Equatable {
  final int id;
  final String name;
  final String? summary;
  final double? rating;
  final String? mediumImageUrl;
  final String? originalImageUrl;
  final String? premiered;

  const Show({
    required this.id,
    required this.name,
    this.summary,
    this.rating,
    this.mediumImageUrl,
    this.originalImageUrl,
    this.premiered,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        summary,
        rating,
        mediumImageUrl,
        originalImageUrl,
        premiered,
      ];
}
