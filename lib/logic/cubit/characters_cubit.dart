import 'package:bloc/bloc.dart';
import 'package:flutter_rickandmorty/data/models/character.dart';
import 'package:flutter_rickandmorty/data/repository/characters_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  void getAll({int page = 1}) {
    charactersRepository.getAll(page: page).then((charactersPage) {
      emit(CharactersLoaded(charactersPage));
    });
  }
}
