import 'package:flutter/material.dart';
import 'package:pokedex_async_redux/api/model/ability.dart';
import 'package:pokedex_async_redux/features/pokemon_details/widgets/pokemon_tile_card.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';

class PokemonAbilitiesView extends StatelessWidget {
  const PokemonAbilitiesView({
    required this.pokemonAbilities,
    super.key,
  });

  final List<Ability> pokemonAbilities;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(paddingSpace20),
      children: [
        for (var ability in pokemonAbilities) PokemonDetailsTileCard(title: ability.ability.name),
      ],
    );
  }
}
