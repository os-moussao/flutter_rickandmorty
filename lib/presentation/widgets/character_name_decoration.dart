import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CharacterNameDecoration extends StatelessWidget {
  const CharacterNameDecoration({
    super.key,
    required this.name,
    this.padding,
    this.fontSize,
  });

  final String name;
  final double? fontSize;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black54,
      padding: padding ?? const EdgeInsets.only(top: 15, bottom: 5),
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
      child: name.text.center.white
          .size(fontSize ?? 16)
          .lineHeight(1.3)
          .maxLines(2)
          .overflow(TextOverflow.ellipsis)
          .make(),
    );
  }
}
