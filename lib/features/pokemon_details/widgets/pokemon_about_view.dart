import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';
import 'package:pokedex_async_redux/utilities/extension/string_extension.dart';

class PokemonAboutView extends StatelessWidget {
  const PokemonAboutView({
    required this.pokemon,
    required this.height,
    required this.weight,
    super.key,
  });

  final Pokemon pokemon;
  final int? height;
  final int? weight;

  @override
  Widget build(BuildContext context) {
    final pokemonImageUrl = pokemon.url.toCustomUrl;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(pokemonImageUrl),
        Text(
          pokemon.name.capitalize(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          '$heightLabel $height',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          '$weightLabel $weight',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
