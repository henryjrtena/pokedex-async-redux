import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:pokedex_async_redux/api/model/pokemon_details.dart';
import 'package:pokedex_async_redux/features/pokemon_details/widgets/pokemon_abilities_view.dart';
import 'package:pokedex_async_redux/features/pokemon_details/widgets/pokemon_about_view.dart';
import 'package:pokedex_async_redux/features/pokemon_details/widgets/pokemon_moves_view.dart';
import 'package:pokedex_async_redux/features/pokemon_details/widgets/pokemon_stats_view.dart';
import 'package:pokedex_async_redux/utilities/async.dart';
import 'package:pokedex_async_redux/utilities/colors.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';
import 'package:flutter/material.dart';

class PokemonDetailsPage extends StatelessWidget {
  const PokemonDetailsPage({
    required this.pokemon,
    required this.pokemonDetails,
    Key? key,
  }) : super(key: key);

  final Pokemon pokemon;
  final Async<PokemonDetails> pokemonDetails;

  @override
  Widget build(BuildContext context) {
    final pokemonDetailsTabs = [
      const Tab(text: aboutLabel),
      const Tab(text: statusLabel),
      const Tab(text: movesLabel),
      const Tab(text: abilitiesLabel),
    ];

    return DefaultTabController(
      length: numberOfTabView,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(appName),
          centerTitle: true,
          backgroundColor: primaryColor,
          bottom: TabBar(
            indicatorWeight: 5.0,
            indicatorColor: primaryColor,
            tabs: pokemonDetailsTabs,
          ),
        ),
        body: pokemonDetails.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (errorMessage) {
            WidgetsBinding.instance.addPostFrameCallback((_) => _showErrorMessageSnackbar(context, errorMessage));
            return const Center(child: Text(noPokemonDetailsAvailableText));
          },
          (data) => TabBarView(
            children: [
              PokemonAboutView(
                pokemon: pokemon,
                height: data.height,
                weight: data.weight,
              ),
              PokemonStatsView(pokemonStats: data.stats),
              PokemonMovesView(pokemonMoves: data.moves),
              PokemonAbilitiesView(pokemonAbilities: data.abilities),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorMessageSnackbar(BuildContext context, String? errorMessage) {
    final snackBar = SnackBar(content: Text(errorMessage ?? emptyString));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
