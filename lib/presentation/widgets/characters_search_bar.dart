import 'package:flutter/material.dart';

class CharactersSearchBar extends StatelessWidget {
  const CharactersSearchBar({
    super.key,
    required this.controller,
    this.onClosed,
    this.onChanged,
  });

  final TextEditingController controller;
  final void Function()? onClosed;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      cursorColor: Colors.grey[900],
      decoration: InputDecoration(
        hintText: 'Find a character...',
        hintStyle: TextStyle(
          color: Colors.grey[900],
          fontSize: 18,
        ),
        filled: true,
        fillColor: Colors.amber,
        contentPadding: const EdgeInsets.all(5),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        prefix: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Close',
          onPressed: onClosed,
          color: Colors.grey[900],
        ),
        suffix: CloseButton(
          onPressed: onClosed,
          color: Colors.grey[900],
        ),
      ),
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      onChanged: onChanged,
    );
  }
}
