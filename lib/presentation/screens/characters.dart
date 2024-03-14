import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 'all characters'.text.makeCentered());
  }
}
