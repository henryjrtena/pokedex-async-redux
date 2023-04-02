import 'package:pokedex_async_redux/features/pokemon_overview/widgets/pokemon_gridview.dart';
import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';

class PokemonFavoritesPage extends StatelessWidget {
  const PokemonFavoritesPage({
    required this.pokemons,
    Key? key,
  }) : super(key: key);

  final List<Pokemon> pokemons;

  @override
  Widget build(BuildContext context) {
    if (pokemons.isEmpty) {
      return const Center(child: Text(noPokemonsAvailableLabel));
    }
    return Scaffold(body: PokemonGridView(pokemons: pokemons));
  }
}
