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
  late List<Character> _characters;
  late Info _pageInfo;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAll();
  }

  Widget buildLoadedList() {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: _characters.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return CharacterCard(_characters[index]);
      },
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          _characters = state.characters.results;
          _pageInfo = state.characters.info;
          return buildLoadedList();
        } else {
          return const SpinKitFadingCircle(
            color: Colors.grey,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Characters'.text.make(),
      ),
      body: buildBlocWidget(),
    );
  }
}
