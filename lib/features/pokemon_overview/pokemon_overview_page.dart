import 'package:pokedex_async_redux/features/pokemon_overview/widgets/pokemon_card.dart';
import 'package:pokedex_async_redux/utilities/async.dart';
import 'package:pokedex_async_redux/utilities/colors.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';
import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:flutter/material.dart';

class PokemonOverviewPage extends StatelessWidget {
  const PokemonOverviewPage({
    required this.pokemons,
    Key? key,
  }) : super(key: key);

  final Async<List<Pokemon>> pokemons;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: pokemons.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (errorMessage) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showErrorMessageSnackbar(errorMessage, context: context);
          });
          return const Center(child: Text(noPokemonsAvailableLabel));
        },
        (data) => GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: pokemonColumnCount),
          itemBuilder: (_, index) {
            final pokemon = data[index];
            return PokemonCard(pokemon: pokemon);
          },
        ),
      ),
    );
  }

  void _showErrorMessageSnackbar(String? errorMessage, {required BuildContext context}) {
    final snackBar = SnackBar(content: Text(errorMessage ??= emptyString));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
