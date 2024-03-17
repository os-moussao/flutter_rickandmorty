import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_rickandmorty/data/models/character.dart';
import 'package:flutter_rickandmorty/data/repository/characters_repository.dart';
import 'package:flutter_rickandmorty/data/services/characters_service.dart';
import 'package:flutter_rickandmorty/logic/cubit/characters_cubit.dart';
import 'package:flutter_rickandmorty/presentation/screens/character_details.dart';
import 'package:flutter_rickandmorty/presentation/screens/characters.dart';
import 'package:flutter_rickandmorty/presentation/widgets/offline_builder_wrapper.dart';
import 'package:flutter_rickandmorty/presentation/widgets/offline_mode.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit characterCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersService());
    characterCubit = CharactersCubit(charactersRepository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CharactersScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => OfflineBuilderWrapper(
            offlineMode: const Scaffold(body: SafeArea(child: OfflineMode())),
            onlineMode: BlocProvider(
              create: (_) => CharactersCubit(charactersRepository),
              child: const CharactersScreen(),
            ),
          ),
        );

      case CharacterDetailsScreen.routeName:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => CharacterDetailsScreen(character: character),
        );

      default:
        throw ErrorDescription('Router: ${settings.name} does not exist');
    }
  }
}
