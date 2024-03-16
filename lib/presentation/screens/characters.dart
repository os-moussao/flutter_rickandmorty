import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rickandmorty/data/models/character.dart';
import 'package:flutter_rickandmorty/logic/cubit/characters_cubit.dart';
import 'package:flutter_rickandmorty/presentation/widgets/character_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});
  static const routeName = '/';

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character> _characters = [];
  final _scrollController = ScrollController();
  List<Character> _searchedCharacters = [];
  final _searchTextController = TextEditingController();
  bool _isSearching = false;

  void setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
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

  // void filterCharacters() {
  //   String query = _searchTextController.text.toLowerCase();
  //   _isSearching = true;
  //   _searchedCharacters = _characters.filter((character) {
  //     String name = character.name.toLowerCase();
  //     return name.startsWith(query);
  //   }).toList();

  //   setState(() {});
  // }

  Widget buildCharactersSearch() {
    return TextField(
      controller: _searchTextController,
      keyboardType: TextInputType.text,
      cursorColor: Colors.grey[900],
      decoration: InputDecoration(
        hintText: 'Find a character...',
        hintStyle: TextStyle(
          color: Colors.grey[900],
          fontSize: 18,
        ),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.amber,
        contentPadding: const EdgeInsets.all(10),
      ),
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      // onChanged: () {},
    );
  }

  Widget buildLoadedList({required bool showProgress}) {
    return Scrollbar(
      controller: _scrollController,
      thickness: 5,
      child: GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 5 / 6,
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
        // title: 'Characters'.text.make(),
        title: buildCharactersSearch(),
        shadowColor: Colors.grey,
        scrolledUnderElevation: 10,
        toolbarHeight: 75,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: buildBlocWidget(),
        ),
      ),
    );
  }
}
