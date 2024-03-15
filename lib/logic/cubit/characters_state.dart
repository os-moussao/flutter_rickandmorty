part of 'characters_cubit.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {
  // if we emit a new state then we will
  // lose the previous state
  // so we will store old characters here
  final List<Character> oldCharacters;

  final bool isFirstPage;

  CharactersLoading(this.oldCharacters, {this.isFirstPage = false});
}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;
  final bool isLastPage;

  CharactersLoaded(this.characters, {this.isLastPage = false});
}

// todo: add error state
