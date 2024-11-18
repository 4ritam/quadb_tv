import '../../domain/entities/cast.dart';

class CastModel extends Cast {
  const CastModel({
    required super.person,
    required super.character,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      person: PersonModel.fromJson(json['person']),
      character: CharacterModel.fromJson(json['character']),
    );
  }

  Map<String, dynamic> toJson() => {
        'person': (person as PersonModel).toJson(),
        'character': (character as CharacterModel).toJson(),
      };
}

class PersonModel extends Person {
  const PersonModel({
    required super.id,
    required super.name,
    super.imageUrl,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image']?['medium'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': {'medium': imageUrl},
      };
}

class CharacterModel extends Character {
  const CharacterModel({
    required super.id,
    required super.name,
    super.imageUrl,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image']?['medium'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': {'medium': imageUrl},
      };
}
