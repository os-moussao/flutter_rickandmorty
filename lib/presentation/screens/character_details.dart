import 'package:flutter/material.dart';
import 'package:flutter_rickandmorty/data/models/character.dart';
import 'package:flutter_rickandmorty/presentation/widgets/character_name_decoration.dart';
import 'package:velocity_x/velocity_x.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key, required this.character});

  static const routeName = '/character';
  final Character character;

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.grey[900],
      flexibleSpace: FlexibleSpaceBar(
        // title: character.name.text.gray900.make(),
        title: SizedBox(
          width: double.infinity,
          child: CharacterNameDecoration(name: character.name),
        ),
        titlePadding: const EdgeInsets.all(0),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
        ],
      ),
    );
  }
}
