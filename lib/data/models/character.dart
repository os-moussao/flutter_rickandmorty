// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Character {
  int id;
  String name;
  String image;
  String species; // Human, Alien...
  String status; // ('Alive', 'Dead' or 'unknown')
  String gender; // ('Female', 'Male', 'Genderless' or 'unknown')
  Map<String, String> origin;
  Map<String, String> location;

  Character({
    required this.id,
    required this.name,
    required this.image,
    required this.species,
    required this.status,
    required this.gender,
    required this.origin,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'species': species,
      'status': status,
      'gender': gender,
      'origin': origin,
      'location': location,
    };
  }

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      species: map['species'] as String,
      status: map['status'] as String,
      gender: map['gender'] as String,
      origin: Map<String, String>.from(map['origin'] as Map<String, dynamic>),
      location:
          Map<String, String>.from(map['location'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Character.fromJson(String source) =>
      Character.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Info {
  int count;
  int pages;
  String? next;
  String? prev;

  Info({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'pages': pages,
      'next': next,
      'prev': prev,
    };
  }

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      count: map['count'] as int,
      pages: map['pages'] as int,
      next: map['next'] != null ? map['next'] as String : null,
      prev: map['prev'] != null ? map['prev'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Info.fromJson(String source) =>
      Info.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PaginatedCharacters {
  Info info;
  List<Character> results;

  PaginatedCharacters({
    required this.info,
    required this.results,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'info': info.toMap(),
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory PaginatedCharacters.fromMap(Map<String, dynamic> map) {
    return PaginatedCharacters(
      info: Info.fromMap(map['info'] as Map<String, dynamic>),
      results: List<Character>.from(
        (map['results'] as List).map<Character>(
          (x) => Character.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginatedCharacters.fromJson(String source) =>
      PaginatedCharacters.fromMap(json.decode(source) as Map<String, dynamic>);
}
