import 'package:bloc/bloc.dart';
import 'package:flutter_rickandmorty/data/models/character.dart';
import 'package:flutter_rickandmorty/data/repository/characters_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  bool isLastPage = false;
  int page = 1;

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  void loadCharacters() {
    final currentState = state;

    if (currentState is CharactersLoading || isLastPage) return;

    var oldCharacters = <Character>[];

    if (currentState is CharactersLoaded) {
      oldCharacters = currentState.characters;
    }

    emit(CharactersLoading(oldCharacters, isFirstPage: page == 1));

    charactersRepository.getAll(page: page).then((newCharacters) {
      page++;

      final allCharacters = [
        ...oldCharacters,
        ...newCharacters.results,
      ];

      isLastPage = newCharacters.info.next == null;

      emit(CharactersLoaded(allCharacters, isLastPage: isLastPage));
    });
  }
}
