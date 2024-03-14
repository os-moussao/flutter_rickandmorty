part of 'character_cubit.dart';

@immutable
sealed class CharacterState {}

final class CharacterInitial extends CharacterState {}

class CharactersLoaded extends CharacterState {
  final PaginatedCharacters characters;

  CharactersLoaded(this.characters);
}
