import 'package:flutter/material.dart';
import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:pokedex_async_redux/features/pokemon_overview/widgets/pokemon_card.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';

class PokemonGridView extends StatelessWidget {
  const PokemonGridView({
    required this.pokemons,
    super.key,
  });

  final List<Pokemon> pokemons;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: pokemons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: pokemonColumnCount),
      itemBuilder: (_, index) {
        final pokemon = pokemons[index];
        return PokemonCard(pokemon: pokemon);
      },
    );
  }
}
