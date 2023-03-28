import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_async_redux/api/model/ability.dart';
import 'package:pokedex_async_redux/utilities/colors.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';

class PokemonAbilitiesView extends StatelessWidget {
  const PokemonAbilitiesView({
    required this.pokemonAbilities,
    super.key,
  });

  final List<Ability> pokemonAbilities;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(space20),
      child: Wrap(
        runSpacing: wrapRunSpacingForWidgets,
        children: [
          for (var ability in pokemonAbilities)
            ListTile(
              tileColor: lightPrimaryColor,
              title: Text(
                ability.ability.name.capitalize(),
                style: const TextStyle(color: white),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                side: BorderSide(
                  width: 1.5,
                  color: primaryColor,
                ),
              ),
            )
        ],
      ),
    );
  }
}
