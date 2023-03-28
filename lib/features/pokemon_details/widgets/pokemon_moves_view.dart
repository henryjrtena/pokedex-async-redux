import 'package:pokedex_async_redux/api/model/move.dart';
import 'package:pokedex_async_redux/features/pokemon_details/widgets/pokemon_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';

class PokemonMovesView extends StatelessWidget {
  const PokemonMovesView({
    required this.pokemonMoves,
    super.key,
  });

  final List<Move> pokemonMoves;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(paddingSpace20),
      children: [for (var move in pokemonMoves) PokemonDetailsTileCard(title: move.move.name)],
    );
  }
}
