import 'package:pokedex_async_redux/utilities/constant.dart';
import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:pokedex_async_redux/features/pokemon_overview/widgets/pokemon_card.dart';
import 'package:flutter/material.dart';

class PokemonOverviewPage extends StatelessWidget {
  const PokemonOverviewPage({
    required this.pokemons,
    Key? key,
  }) : super(key: key);

  final List<Pokemon> pokemons;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: GridView.builder(
        padding: overviewPagePadding,
        itemCount: pokemons.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: pokemonOverviewPerColumn),
        itemBuilder: (context, index) {
          return PokemonCard(
            pokemon: pokemons[index],
            pokemonId: index,
          );
        },
      ),
    );
  }
}
