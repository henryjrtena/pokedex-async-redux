import 'package:pokedex_async_redux/api/model/move.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

class PokemonMovesView extends StatelessWidget {
  const PokemonMovesView({
    required this.pokemonMoves,
    super.key,
  });

  final List<Move> pokemonMoves;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(space20),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 5.0,
        children: [
          for (var move in pokemonMoves) Chip(label: Text(move.move.name.capitalize())),
        ],
      ),
    );
  }
}
