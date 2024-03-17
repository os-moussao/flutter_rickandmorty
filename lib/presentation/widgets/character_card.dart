import 'package:flutter/material.dart';
import '../../data/models/character.dart';
import '../screens/character_details.dart';
import 'character_name_decoration.dart';

class CharacterCard extends StatelessWidget {
  final Character _character;

  const CharacterCard(this._character, {super.key});

  Widget loadCharacterImage() {
    if (_character.image.isEmpty) {
      return Image.asset('assets/img/placeholder.jpeg', fit: BoxFit.cover);
    }

    return FadeInImage.assetNetwork(
      placeholder: 'assets/img/placeholder.jpeg',
      image: _character.image,
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget displayCardData() {
    return GridTile(
      footer: CharacterNameDecoration(name: _character.name),
      child: loadCharacterImage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          CharacterDetailsScreen.routeName,
          arguments: _character,
        );
      },
      child: Container(
        // color: Colors.grey,
        decoration: BoxDecoration(
          color: const Color.fromARGB(19, 158, 158, 158),
          borderRadius: BorderRadius.circular(12),
        ),
        // for the child to inherit the border radius
        clipBehavior: Clip.hardEdge,
        child: Hero(
          tag: _character.id,
          child: displayCardData(),
        ),
      ),
    );
  }
}
