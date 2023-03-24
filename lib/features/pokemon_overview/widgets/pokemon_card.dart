import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';
import 'package:pokedex_async_redux/utilities/extension/string_extension.dart';
import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final imageUri = Uri.parse(imageUrl);
    final uri = imageUri.replace(path: '${imageUri.path}${pokemon.url.getPokemonId()}.png');
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network('$uri'),
          Text(
            pokemon.name.capitalize(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
