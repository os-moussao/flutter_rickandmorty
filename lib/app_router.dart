import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rickandmorty/data/repository/characters_repository.dart';
import 'package:flutter_rickandmorty/data/services/characters_service.dart';
import 'package:flutter_rickandmorty/logic/cubit/character_cubit.dart';
import 'package:flutter_rickandmorty/presentation/screens/characters.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharacterCubit characterCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersService());
    characterCubit = CharacterCubit(charactersRepository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CharactersScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => CharacterCubit(charactersRepository),
            child: const CharactersScreen(),
          ),
        );
      default:
        throw ErrorDescription('Router: ${settings.name} does not exist');
    }
  }
}
