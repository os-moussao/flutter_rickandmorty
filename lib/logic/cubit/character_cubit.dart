import 'package:bloc/bloc.dart';
import 'package:flutter_rickandmorty/data/models/character.dart';
import 'package:flutter_rickandmorty/data/repository/characters_repository.dart';
import 'package:meta/meta.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharactersRepository charactersRepository;
  late PaginatedCharacters characters;

  CharacterCubit(this.charactersRepository) : super(CharacterInitial());

  PaginatedCharacters getAll({int page = 1}) {
    charactersRepository.getAll(page: page).then((charactersPage) {
      emit(CharactersLoaded(charactersPage));
      characters = charactersPage;
    });

    return characters;
  }
}
