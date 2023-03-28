import 'package:pokedex_async_redux/utilities/colors.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';
import 'package:pokedex_async_redux/utilities/spacing.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

class PokemonDetailsTileCard extends StatelessWidget {
  const PokemonDetailsTileCard({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          tileColor: lightPrimaryColor,
          title: Text(
            title.capitalize(),
            style: const TextStyle(
              color: white,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            side: BorderSide(
              width: 1.5,
              color: primaryColor,
            ),
          ),
        ),
        const VerticalSpacing(height: tileCardSpaceBottom)
      ],
    );
  }
}
