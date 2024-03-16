import 'package:flutter/material.dart';
import 'package:flutter_rickandmorty/data/models/character.dart';
import 'package:velocity_x/velocity_x.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key, required this.character});

  static const routeName = '/character';
  final Character character;

  @override
  Widget build(BuildContext context) {
    return character.name.text.makeCentered();
  }
}
