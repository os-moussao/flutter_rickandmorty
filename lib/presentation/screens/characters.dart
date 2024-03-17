import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_rickandmorty/data/models/character.dart';
import 'package:flutter_rickandmorty/logic/cubit/characters_cubit.dart';
import 'package:flutter_rickandmorty/presentation/widgets/character_card.dart';
import 'package:flutter_rickandmorty/presentation/widgets/characters_search_bar.dart';
import 'package:flutter_rickandmorty/presentation/widgets/offline_mode.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:velocity_x/velocity_x.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});
  static const routeName = '/';

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character> _allCharacters = [];
  List<Character> _searchedCharacters = [];
  ScrollDirection _scrollDirection = ScrollDirection.idle; // no scrolling
  bool _isSearching = false;
  final _scrollController = ScrollController();
  final _searchTextController = TextEditingController();

  void setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isSearching) {
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

  @override
  void dispose() {
    _searchTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void filterCharacters(String query) {
    _searchedCharacters = _allCharacters.filter((character) {
      String name = character.name.toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {});
  }

  Widget buildCharactersSearch() {
    return CharactersSearchBar(
      controller: _searchTextController,
      onClosed: () {
        setState(() {
          _searchTextController.clear();
          _isSearching = false;
        });
      },
      onChanged: filterCharacters,
    );
  }

  Widget buildLoadedList({required bool showProgress}) {
    final displayCharacters =
        _isSearching ? _searchedCharacters : _allCharacters;

    return Scrollbar(
      controller: _scrollController,
      thickness: 5,
      child: OrientationBuilder(
        builder: (_, orientation) => GridView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            childAspectRatio: orientation == Orientation.portrait ? 5 / 6 : 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 30,
          ),
          itemCount: displayCharacters.length + (showProgress ? 2 : 0),
          itemBuilder: (context, index) {
            if (index >= displayCharacters.length) {
              return const Center(
                child: SpinKitFadingCircle(
                  color: Colors.grey,
                ),
              );
            }
            return CharacterCard(displayCharacters[index]);
          },
        ),
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
          _allCharacters = state.oldCharacters;
        } else if (state is CharactersLoaded) {
          _allCharacters = state.characters;
          showProgress = !state.isLastPage && !_isSearching;
        }

        return buildLoadedList(showProgress: showProgress);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildAppBarTitle(),
        actions: buildAppBarActions(),
        shadowColor: Colors.grey,
        scrolledUnderElevation:
            _scrollDirection == ScrollDirection.reverse ? 15 : 0,
        toolbarHeight: 70,
      ),
      body: buildScreenBody(),
      floatingActionButton: _scrollDirection == ScrollDirection.forward
          ? FloatingActionButton.small(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              onPressed: _scrollController.jumpToTop,
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }

  OfflineBuilder buildScreenBody() {
    return OfflineBuilder(
      connectivityBuilder: (context, connectivity, child) {
        final isOffline = connectivity == ConnectivityResult.none;

        if (isOffline) {
          return const OfflineMode();
        } else {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              _scrollDirection = notification.direction;
              setState(() {});
              return true;
            },
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                child: buildBlocWidget(),
              ),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  List<Widget> buildAppBarActions() {
    if (_isSearching) return [];
    return [
      Container(
        margin: const EdgeInsets.only(right: 15),
        child: IconButton(
          onPressed: () {
            setState(() {
              _isSearching = true;
              _searchedCharacters = _allCharacters;
            });
          },
          icon: const Icon(Icons.search),
        ),
      ),
    ];
  }

  Widget buildAppBarTitle() =>
      _isSearching ? buildCharactersSearch() : 'Characters'.text.make();
}
