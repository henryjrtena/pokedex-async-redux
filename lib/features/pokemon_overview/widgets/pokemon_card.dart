import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:pokedex_async_redux/features/pokemon_details/pokemon_details_connector.dart';
import 'package:pokedex_async_redux/utilities/extension/string_extension.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToPokemonDetailsPage(context),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.network(pokemon.url.toCustomUrl)),
            Text(
              pokemon.name.capitalize(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPokemonDetailsPage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PokemonDetailsConnector(pokemon: pokemon)),
    );
  }
}
