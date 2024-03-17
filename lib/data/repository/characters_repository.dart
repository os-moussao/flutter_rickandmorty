import '../models/character.dart';
import '../services/characters_service.dart';

class CharactersRepository {
  final CharactersService charactersService;

  CharactersRepository(this.charactersService);

  Future<PaginatedCharacters> getAll({int page = 1}) async {
    final result = await charactersService.getAll(page: page);
    return PaginatedCharacters.fromMap(result);
  }
}

// void main() async {
//   final ch = CharactersRepository(CharactersService());
//   final x = await ch.getAll();
//   print(x.results[0].toMap());
// }