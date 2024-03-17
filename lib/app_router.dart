import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/models/character.dart';
import 'data/repository/characters_repository.dart';
import 'data/services/characters_service.dart';
import 'logic/cubit/characters_cubit.dart';
import 'presentation/screens/character_details.dart';
import 'presentation/screens/characters.dart';
import 'presentation/widgets/offline_builder_wrapper.dart';
import 'presentation/widgets/offline_mode.dart';

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
