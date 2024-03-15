import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rickandmorty/data/models/character.dart';
import 'package:flutter_rickandmorty/logic/cubit/characters_cubit.dart';
import 'package:flutter_rickandmorty/presentation/widgets/character_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:velocity_x/velocity_x.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});
  static const routeName = '/';

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character> _characters = [];
  final scrollController = ScrollController();

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        BlocProvider.of<CharactersCubit>(context).loadCharacters();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setupScrollController();
    BlocProvider.of<CharactersCubit>(context).loadCharacters();
  }

  Widget buildLoadedList({required bool showProgress}) {
    return Scrollbar(
      controller: scrollController,
      thickness: 5,
      child: GridView.builder(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 30,
        ),
        itemCount: _characters.length + (showProgress ? 2 : 0),
        itemBuilder: (context, index) {
          if (index >= _characters.length) {
            return const Center(
              child: SpinKitFadingCircle(
                color: Colors.grey,
              ),
            );
          }
          return CharacterCard(_characters[index]);
        },
      ),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      // todo: handle error case
      builder: (context, state) {
        if (state is CharactersLoading && state.isFirstPage) {
          return const Center(
            child: SpinKitFadingCircle(
              color: Colors.grey,
            ),
          );
        }

        bool showProgress = true;
        if (state is CharactersLoading) {
          _characters = state.oldCharacters;
        } else if (state is CharactersLoaded) {
          _characters = state.characters;
          showProgress = !state.isLastPage;
        }

        return buildLoadedList(showProgress: showProgress);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Characters'.text.make(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
          child: buildBlocWidget(),
        ),
      ),
    );
  }
}
