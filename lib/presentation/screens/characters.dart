import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rickandmorty/logic/cubit/characters_cubit.dart';
import 'package:velocity_x/velocity_x.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});
  static const routeName = '/';

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Characters'.text.make(),
      ),
      body: 'all characters'.text.makeCentered(),
    );
  }
}
