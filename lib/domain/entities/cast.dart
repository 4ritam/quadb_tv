import 'package:equatable/equatable.dart';

class Cast extends Equatable {
  final Person person;
  final Character character;

  const Cast({
    required this.person,
    required this.character,
  });

  @override
  List<Object?> get props => [person, character];
}

class Person extends Equatable {
  final int id;
  final String name;
  final String? imageUrl;

  const Person({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, imageUrl];
}

class Character extends Equatable {
  final int id;
  final String name;
  final String? imageUrl;

  const Character({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, imageUrl];
}
