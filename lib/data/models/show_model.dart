import 'package:quadb_tv/core/helper/html_parser.dart';

import '../../domain/entities/show.dart';

class ShowModel extends Show {
  const ShowModel({
    required super.id,
    required super.name,
    super.summary,
    super.rating,
    super.mediumImageUrl,
    super.originalImageUrl,
    super.premiered,
  });

  factory ShowModel.fromJson(Map<String, dynamic> json) {
    return ShowModel(
      id: json['show']['id'],
      name: json['show']['name'],
      summary: htmlParse(json['show']['summary'])?.trim(),
      rating: json['show']['rating']['average']?.toDouble() ?? 0,
      mediumImageUrl: json['show']['image']?['medium'],
      originalImageUrl: json['show']['image']?['original'],
      premiered: json['show']['premiered'].toString().split('-').first,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, String?> image = {};
    image['medium'] = mediumImageUrl;
    image['original'] = originalImageUrl;
    return {
      'show': {
        'id': id,
        'name': name,
        'summary': summary,
        'rating': {'average': rating},
        'image': image,
        'premiered': premiered ?? "2024"
      }
    };
  }
}
