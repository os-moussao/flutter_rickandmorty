import 'package:flutter/material.dart';
import 'package:flutter_rickandmorty/data/models/character.dart';
import 'package:flutter_rickandmorty/presentation/widgets/character_name_decoration.dart';
import 'package:velocity_x/velocity_x.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key, required this.character});

  static const routeName = '/character';
  final Character character;

  Widget buildHeadlineText(String text) {
    return text.text.gray400.size(20).make();
  }

  Widget buildSubtitleText(String text) {
    return text.text.white.size(18).make().pOnly(bottom: 10);
  }

  Widget buildCharacterStatus() {
    Icon statusIcon = Icon(
      Icons.circle,
      color: character.status == 'Alive' ? Colors.green : Colors.red,
    );

    if (character.status == 'unknown') {
      statusIcon = Icon(
        Icons.question_mark,
        color: Colors.grey[400],
        size: 18,
      );
    }

    return Row(
      children: [
        statusIcon.pOnly(bottom: 10),
        const WidthBox(10),
        buildSubtitleText(character.status.capitalized),
      ],
    );
  }

  Widget buildSliverAppBar(context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 3 / 4,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.amber[600],
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
          buildSliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeadlineText('Species:'),
                    buildSubtitleText(character.species),
                    buildHeadlineText('Gender:'),
                    buildSubtitleText(character.gender),
                    buildHeadlineText('Status:'),
                    buildCharacterStatus(),
                    buildHeadlineText('Last known location:'),
                    buildSubtitleText(character.location['name']!),
                    buildHeadlineText('Origin:'),
                    buildSubtitleText(character.origin['name']!),
                  ],
                ),
              ),
              const HeightBox(500),
            ]),
          ),
        ],
      ),
    );
  }
}
