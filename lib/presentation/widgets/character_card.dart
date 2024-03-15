import 'package:flutter/material.dart';
import 'package:flutter_rickandmorty/data/models/character.dart';
import 'package:velocity_x/velocity_x.dart';

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

  Widget displayCharacterData() {
    return Container(
      // color: Colors.black54,
      padding: const EdgeInsets.only(top: 15),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black54,
            Colors.black45,
            Colors.black12,
            Colors.transparent
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.5, 0.7, 0.9, 1],
        ),
      ),
      child: _character.name.text.center.white
          .size(16)
          .lineHeight(1.3)
          .maxLines(2)
          .overflow(TextOverflow.ellipsis)
          .make()
          .p(5),
    );
  }

  Widget displayCardData() {
    return GridTile(
      footer: displayCharacterData(),
      child: loadCharacterImage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey,
      decoration: BoxDecoration(
        color: const Color.fromARGB(19, 158, 158, 158),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.hardEdge, // for the child to inherit the border radius
      child: displayCardData(),
    );
  }
}
